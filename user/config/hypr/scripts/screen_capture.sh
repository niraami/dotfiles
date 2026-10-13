#!/usr/bin/env bash

set -e -o pipefail

# Static variables
image_output_dir="$(xdg-user-dir PICTURES)/Screenshots"
video_output_dir="$(xdg-user-dir VIDEOS)/Recordings"

time_format="%Y-%m-%d_%H-%M-%S"

image_name_postfix=""
video_name_postfix=""

image_options=(
    "Capture region=region"
    "Capture screen=output"
    "Capture window=window"
)

video_options=(
    "Record region=region"
    "Record screen=output"
    "Record window=window"
)

video_formats=(
    "MP4 (H.264)=h264"
    "MP4 (H.265)=h265"
    "MP4 (AV1)=av1"
    "GIF=gif"
)

video_fps=(
    "24 fps=24"
    "30 fps=30"
    "60 fps=60"
)

gif_fps=(
    "15 fps=15"
    "24 fps=24"
    "30 fps=30"
)

# Overridable variables
action=""
mode=""
format=""
fps=""

show_help() {
    cat <<EOF
Usage: $0 -a ACTION

Options:
  -a, --action    Specify action (image, video)
  -m, --mode      Specify capture mode (region, window, output)
  -f, --format    Specify video format (h264, h265, av1, gif)
  -r, --fps       Specify video framerate (24, 30, 60; gif: 15, 24, 30)
  -h, --help      Display this help and exit
EOF
}

while [[ $# -gt 0 ]]; do
    case $1 in
        -a|--action)
            action="$2"
            shift 2
            ;;
        -f|--format)
            format="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        -m|--mode)
            mode="$2"
            shift 2
            ;;
        -r|--fps)
            fps="$2"
            shift 2
            ;;
        *)
            echo "Invalid option: $1" >&2
            show_help
            exit 1
            ;;
    esac
done

# Accept "screen" as an alias for "output" (the actual mode name)
if [ "${mode}" = "screen" ]; then
    mode="output"
fi

# Shows the labels of the "label=value" entries in the array passed by name as
# a fuzzel menu and prints the value of the chosen entry; fails if dismissed
fuzzel_prompt() {
    local -n _options="$1"
    local choice
    choice="$(printf '%s\n' "${_options[@]%%=*}" | fuzzel \
        --dmenu \
        --prompt "󰄀 " \
        --width 25 \
        --lines 6 \
        --log-level=none)" || return 1

    [ -n "${choice}" ] || return 1
    local entry
    for entry in "${_options[@]}"; do
        if [ "${entry%%=*}" = "${choice}" ]; then
            printf '%s' "${entry#*=}"
            return 0
        fi
    done
    return 1
}

# Sends a notification for a saved capture; extra arguments are additional
# dunstify action specs ("name,label") on top of the default "open" one
notify_dialog() {
    local summary="$1" body="$2" icon="$3" file_path="$4"
    shift 4

    local -a dunst_args=(
        --appname="Screen Capture"
        --urgency="low"
        --icon="${icon}"
        --action="open,Open file location"
    )
    local spec
    for spec in "$@"; do
        dunst_args+=(--action="${spec}")
    done

    local notify_action
    notify_action="$(dunstify "${dunst_args[@]}" "${summary}" "${body}")" || return 0

    case "${notify_action}" in
        "open")
            xdg-open "$(dirname "${file_path}")"
            ;;
        "edit")
            swappy --file "${file_path}"
            ;;
    esac
}

# Prints the geometry of a window picked from those on visible workspaces
grab_window() {
    local active_workspaces
    active_workspaces="$(hyprctl -j monitors | jq -c '[.[].activeWorkspace.id]')"

    local boxes
    boxes="$(hyprctl -j clients | jq -r --argjson ws "${active_workspaces}" \
        '.[] | select(.workspace.id as $id | $ws | index($id))
         | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')"
    [ -n "${boxes}" ] || return 1

    slurp -r <<< "${boxes}"
}

# Clips "x,y WxH" geometry to the output it overlaps the most and prints the
# result; wf-recorder only accepts geometry fully inside a single output
trim_geometry() {
    hyprctl -j monitors | jq -r --arg geom "$1" \
        '($geom | capture("(?<x>-?[0-9]+),(?<y>-?[0-9]+) (?<w>[0-9]+)x(?<h>[0-9]+)")
                | map_values(tonumber)) as $w
         | [.[] | . as $m
            | ($m.width / $m.scale | round) as $mw
            | ($m.height / $m.scale | round) as $mh
            | ([$w.x, $m.x] | max) as $ix
            | ([$w.y, $m.y] | max) as $iy
            | ([$w.x + $w.w, $m.x + $mw] | min) as $ix2
            | ([$w.y + $w.h, $m.y + $mh] | min) as $iy2
            | {x: $ix, y: $iy, w: ($ix2 - $ix), h: ($iy2 - $iy)}]
         | max_by(.w * .h)
         | select(.w > 0 and .h > 0)
         | "\(.x),\(.y) \(.w)x\(.h)"'
}

capture_image() {
    if [ -z "${mode}" ]; then
        mode="$(fuzzel_prompt image_options)" || exit 0

        # Wait for fuzzel to close
        sleep 0.9
    fi

    local file_name
    file_name="$(date "+${time_format}")${image_name_postfix:+_"${image_name_postfix}"}"
    local output_path="${image_output_dir}/${file_name}.png"

    hyprshot --silent --freeze --mode "${mode}" \
        --filename "Screenshots/${file_name}.png" || true

    # hyprshot may return before the file hits disk; when the selection is
    # cancelled no file appears at all
    for _ in {1..15}; do
        if [ -f "${output_path}" ]; then
            break
        fi
        sleep 0.1
    done
    [ -f "${output_path}" ] || exit 0

    notify_dialog "Screen capture" "Capture saved to ${output_path}" \
        "${output_path}" "${output_path}" "edit,Edit with swappy" &
}

capture_video() {
    # Re-running while a recording is in progress stops it
    if pgrep -x wf-recorder > /dev/null; then
        pkill -INT -x wf-recorder
        exit 0
    fi

    local prompted=0
    if [ -z "${mode}" ]; then
        mode="$(fuzzel_prompt video_options)" || exit 0
        prompted=1
    fi
    if [ -z "${format}" ]; then
        format="$(fuzzel_prompt video_formats)" || exit 0
        prompted=1
    fi
    if [ -z "${fps}" ]; then
        local fps_options="video_fps"
        if [ "${format}" = "gif" ]; then
            fps_options="gif_fps"
        fi
        fps="$(fuzzel_prompt "${fps_options}")" || exit 0
        prompted=1
    fi

    # Wait for fuzzel to close
    if [ "${prompted}" -eq 1 ]; then
        sleep 0.9
    fi

    local -a recorder_args=(-y)
    local selection geometry
    case "${mode}" in
        "region")
            selection="$(slurp -d)" || exit 0
            [ -n "${selection}" ] || exit 0
            geometry="$(trim_geometry "${selection}")"
            [ -n "${geometry}" ] || exit 1
            recorder_args+=(-g "${geometry}")
            ;;
        "output")
            selection="$(slurp -or -f "%o")" || exit 0
            [ -n "${selection}" ] || exit 0
            recorder_args+=(-o "${selection}")
            ;;
        "window")
            selection="$(grab_window)" || exit 0
            [ -n "${selection}" ] || exit 0
            geometry="$(trim_geometry "${selection}")"
            [ -n "${geometry}" ] || exit 1
            recorder_args+=(-g "${geometry}")
            ;;
        *)
            echo "Invalid mode: ${mode}" >&2
            exit 1
            ;;
    esac

    local ext
    case "${format}" in
        "h264")
            ext="mp4"
            recorder_args+=(-c libx264 -x yuv420p -r "${fps}")
            ;;
        "h265")
            ext="mp4"
            recorder_args+=(-c libx265 -x yuv420p -r "${fps}")
            ;;
        "av1")
            # libsvtav1 and librav1e both fail under wf-recorder 0.6.0
            # (bad parameter / panic) - either might work in a future version
            # and would be preferable to libaom's software encoder
            ext="mp4"
            recorder_args+=(-c libaom-av1 -x yuv420p -p usage=realtime -p cpu-used=8 -r "${fps}")
            ;;
        "gif")
            ext="gif"
            recorder_args+=(-c gif -F "fps=${fps},split[s0][s1];[s0]palettegen=stats_mode=single[p];[s1][p]paletteuse=dither=bayer")
            ;;
        *)
            echo "Invalid format: ${format}" >&2
            exit 1
            ;;
    esac

    local file_name
    file_name="$(date "+${time_format}")${video_name_postfix:+_"${video_name_postfix}"}"
    local output_path="${video_output_dir}/${file_name}.${ext}"
    mkdir -p "${video_output_dir}"

    wf-recorder "${recorder_args[@]}" -f "${output_path}" &
    local recorder_pid=$!

    dunstify --appname="Screen Capture" --urgency="low" \
        "Screen recording" \
        "Recording to ${output_path}, re-run to stop" &

    if wait "${recorder_pid}"; then
        if [ -f "${output_path}" ]; then
            notify_dialog "Screen recording" "Recording saved to ${output_path}" \
                "video-x-generic" "${output_path}" &
        fi
    else
        dunstify --appname="Screen Capture" --urgency="critical" \
            "Screen recording" "Recording failed" &
    fi
}

case "${action}" in
    "image")
        capture_image
        ;;
    "video")
        capture_video
        ;;
    *)
        echo "Invalid action: ${action}" >&2
        show_help
        exit 1
        ;;
esac

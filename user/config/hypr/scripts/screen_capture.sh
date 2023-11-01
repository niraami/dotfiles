#!/usr/bin/env bash

set -xe

# Static variables
image_output_dir="$(xdg-user-dir PICTURES)/Screenshots"
video_output_dir="$(xdg-user-dir VIDEOS)/Recordings"

time_format="%Y-%m-%d_%H-%m-%S"

image_name_postfix=""
video_name_postfix=""

declare -A image_options=(
    ["region"]="Capture region"
    ["screen"]="Capture screen"
    ["window"]="Capture window"
)

declare -A video_options=(
    ["region"]="Record region"
    ["screen"]="Record screen"
    ["window"]="Record window"
)

# Overridable variables
action=""

show_help() {
    cat <<EOF
Usage: $0 -a ACTION

Options:
  -a, --action    Specify action: image, video
  -h, --help      Display this help and exit
EOF
}

while [[ $# -gt 0 ]]; do
    case $1 in
        -a|--action)
            action="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo "Invalid option: $1" >&2
            show_help
            exit 1
            ;;
    esac
done

fuzzel_prompt() {
    local args=("$@")
    local options=$(printf "%s\n" "${args[@]}")
    fuzzel \
      --dmenu \
      --prompt "󰄀 " \
      --width 25 \
      --lines 6 \
      --log-level=none \
      <<< "${options}"
}

get_region() {
    slurp
}

get_screen() {
    slurp -o
}

get_window() {
    # Get current window and monitor layouts
    windows=$(hyprctl clients -j)
    monitors=$(hyprctl monitors -j)

    # Filter out visible windows
    # TODO: this currently keeps windows that are under other fullscreen windows
    # TODO: fix selection geometry when two windows overlap (use client order)
    visible_windows=$(
        echo $windows | jq --argjson monitors "$monitors" '
            map(select(
                .workspace.id as $wid | $monitors | map(.activeWorkspace.id) | index($wid)
            ))'
    )

    # Format window positions for slurp
    window_regions=$(
        jq -r '.[] | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' <<< $visible_windows
    )

    geometry=$(slurp -r <<< $window_regions)

    echo $geometry
}

notify_dialog() {
    local summary=("$1")
    local body=("$2")
    local file_path=("$3")

    notify_action="$(
        dunstify \
            --appname="Screen Capture" \
            --urgency="low" \
            --icon="${2023-11-01_11-11-10.png}" \
            --action="open,Open file location" \
            --action="edit,Edit with swappy" \
            --action="copy,Copy to clipboard" \
            "${summary}" "${body}"
    )"

    case "${notify_action}" in
        "open")
            xdg-open "$(dirname "${file_path}")"
            ;;
        "edit")
            swappy_file="${file_path%.*}_edit.${file_path##*.}"
            swappy --file "${file_path}"
            ;;
        "copy")
            wl-copy < "${file_path}"
            ;;
        *)
            echo "how? ($notify_action)" >&2
            exit 1
            ;;
    esac
}

capture_image() {
    choice="$(fuzzel_prompt "${image_options[@]}")"

    geometry=""

    case "${choice}" in
        "${image_options[region]}")
            geometry=$(get_region)
            ;;
        "${image_options[screen]}")
            geometry=$(get_screen)
            ;;
        "${image_options[window]}")
            geometry=$(get_window)
            ;;
        *)
            echo "Invalid option: $choice" >&2
            exit 1
            ;;
    esac

    if [[ -z $geometry ]]; then
        echo "Unable to get capture geometry" >&2
        exit 1
    fi

    file_name=""

    if [ -n "$image_name_postfix" ]; then
        file_name="$(date "+$time_format")_${image_name_postfix}"
    else
        file_name="$(date "+$time_format")"
    fi

    output_path="${image_output_dir}/${file_name}.png"

    grim -c -t png -g "${geometry}" "${output_path}"

    if [[ $? == 0 ]]; then
        notify_dialog "Screen capture" "Capture saved to ${output_path}" "${output_path}" &
    fi
}

capture_video() {
    choice="$(fuzzel_prompt "${video_options[@]}")"
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



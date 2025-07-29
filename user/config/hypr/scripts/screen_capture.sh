#!/usr/bin/env bash

set -xe

# Static variables
image_output_dir="$(xdg-user-dir PICTURES)/Screenshots"
video_output_dir="$(xdg-user-dir VIDEOS)/Recordings"

time_format="%Y-%m-%d_%H-%M-%S"

image_name_postfix=""
video_name_postfix=""

declare -A image_options=(
    ["Capture region"]="region"
    ["Capture screen"]="screen"
    ["Capture window"]="window"
)

declare -A video_options=(
    ["Record region"]="region"
    ["Record screen"]="screen"
    ["Record window"]="window"
)

# Overridable variables
action=""
mode=""

show_help() {
    cat <<EOF
Usage: $0 -a ACTION

Options:
  -a, --action    Specify action (image, video)
  -m, --mode      Specify capture mode (region, window, output)
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
        -m|--mode)
            mode="$2"
            shift 2
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
    local choice="$(fuzzel \
      --dmenu \
      --prompt "󰄀 " \
      --width 25 \
      --lines 6 \
      --log-level=none \
      <<< "${options}")"

    echo "${image_options["${choice}"]}"
}

notify_dialog() {
    local summary=("$1")
    local body=("$2")
    local file_path=("$3")

    notify_action="$(
        dunstify \
            --appname="Screen Capture" \
            --urgency="low" \
            --icon="${file_path}" \
            --action="open,Open file location" \
            --action="edit,Edit with swappy" \
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
        *)
            echo "how? ($notify_action)" >&2
            exit 1
            ;;
    esac
}

capture_image() {
    if [ -z "$mode" ]; then
        mode="$(fuzzel_prompt "${!image_options[@]}")"

        # Wait for fuzzel to close
        sleep 0.9
    fi

    local file_name=""

    if [ -n "$image_name_postfix" ]; then
        file_name="$(date "+$time_format")_${image_name_postfix}"
    else
        file_name="$(date "+$time_format")"
    fi

    local output_path="${image_output_dir}/${file_name}.png"
    response="$(hyprshot --silent --freeze --mode "${mode}" --filename "Screenshots/${file_name}.png")"

    # Prevent notification if user cancelled the capture
    if [ -z "${response}" ]; then
        sleep 0.2
        notify_dialog "Screen capture" "Capture saved to ${output_path}" "${output_path}" &
    fi
}

capture_video() {
    choice="$(fuzzel_prompt "${!video_options[@]}")"
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



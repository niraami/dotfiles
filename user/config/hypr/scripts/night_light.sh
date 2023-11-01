#!/usr/bin/env bash

set -e

shader_dir="$XDG_CONFIG_HOME/hypr/shaders"
action=""

show_help() {
    cat <<EOF
Usage: $0 -a ACTION

Options:
  -a, --action    Specify action: get_state, toggle
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

if [ -z "$action" ]; then
    echo "Action is required! Use -a or --action." >&2
    show_help
    exit 1
fi

# Get the status of decoration:screen_shader
status=$(hyprctl getoption decoration:screen_shader | awk -F': ' '/str:/{print ($2 == "\"[[EMPTY]]\"") ? "off" : "on"}')

if [ "$action" == "get_state" ]; then
    echo "{\"alt\": \"$status\", \"tooltip\": \"Night light $status\", \"class\": \"$status\"}"
    exit 0
elif [ "$action" == "toggle" ]; then
    if [ "$status" == "off" ]; then
        hyprctl keyword decoration:screen_shader "${shader_dir}/blue_light_filter.glsl" > /dev/null
        echo "{\"alt\": \"on\", \"tooltip\": \"Night light on\", \"class\": \"on\"}"
    else
        hyprctl keyword decoration:screen_shader "[[EMPTY]]" > /dev/null
        echo "{\"alt\": \"off\", \"tooltip\": \"Night light off\", \"class\": \"off\"}"
    fi
else
    echo "Unknown action '$action'!" >&2
    exit 1
fi

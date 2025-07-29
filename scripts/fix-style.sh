#!/usr/bin/env bash

set -eu -o pipefail

script_name="$(basename -- "$0")"
script_base_dir="$(realpath -e -- "$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")")"

base_dir="$(realpath -e -- "$script_base_dir/..")"
script_dir="${base_dir}/scripts"

# Sort and fix style of all dotfiles and profiles alphabetically
yq -i 'sort_keys(.dotfiles) | sort_keys(.profiles)' "${base_dir}/config-system.yml"
yq -i 'sort_keys(.dotfiles) | sort_keys(.profiles)' "${base_dir}/config-user.yml"

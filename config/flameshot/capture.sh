src_path="${HOME}/Screenshots/$(date '+%Y-%m')"
mkdir -p "${src_path}"

flameshot gui -p "${scr_path}"

src_path="${HOME}/Screenshots/$(date '+%Y-%m')"
mkdir -p "${scr_path}"

flameshot gui -p "${scr_path}"

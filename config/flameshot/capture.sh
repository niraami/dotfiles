path="${HOME}/Screenshots/$(date '+%Y-%m')"
mkdir -p "${path}"

flameshot gui -p "${path}"

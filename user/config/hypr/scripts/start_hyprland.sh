#!/bin/sh

# Add user entries to path
# PATH="$PATH"
# export PATH

cd ~ || exit

# Wayland (hyprland)
export WLR_NO_HARDWARE_CURSORS=1
export XCURSOR_THEME=Colloid-cursors
export XCURSOR_SIZE=24

export QT_QPA_PLATFORMTHEME=qt5ct
export QT_QPA_PLATFORM="wayland;xcb"
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export QT_STYLE_OVERRIDE=kvantum

export MOZ_DISABLE_RDD_SANDBOX=1
export EGL_PLATFORM=wayland
export MOZ_ENABLE_WAYLAND=1
export NVD_BACKEND=direct
export WLR_BACKEND=vulkan
export GDK_BACKEND="wayland,x11"

export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_DESKTOP=Hyprland

export LIBVA_DRIVER_NAME=nvidia
export GBM_BACKEND=nvidia-drm
export __NV_PRIME_RENDER_OFFLOAD=1
export __VK_LAYER_NV_optimus=NVIDIA_only
export __GLX_VENDOR_LIBRARY_NAME=nvidia

export HYPRSHOT_DIR="$HOME/Pictures/Screenshots"

export EDITOR=/usr/bin/vim
export SYSTEMD_EDITOR="$EDITOR"
export SUDO_EDITOR="$EDITOR"
export VISUAL="$EDITOR"

# Export SSH agent socket path
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# exec Hyprland
exec Hyprland &> /tmp/hyprland-$(date +%Y%m%d%H%M%S).log

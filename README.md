# Personal dotfiles
Dotfiles - also known as: *I'm never using linux again If I lose these files*.

## Screenshots
![](https://user-images.githubusercontent.com/24532624/236953589-bc75e335-02dc-4cb8-9985-32a8da21e0f8.png)

## Environment
- Distribution: [Arch Linux](https://www.archlinux.org/)
- Compositor: [hyprland](https://hyprland.org/) (Wayland)
- Bar: [waybar](https://github.com/Alexays/Waybar)
- Notification daemon: [swaync](https://github.com/ErikReider/SwayNotificationCenter)
- Wallpaper daemon: [swww](https://github.com/Horus645/swww)
- Color scheme:
  - [colloid-gtk](https://github.com/vinceliuice/Colloid-gtk-theme) (purple dark compact)
  - [colloid-kde](https://github.com/vinceliuice/Colloid-kde) (dark + [kvantum](https://github.com/tsujan/Kvantum))
  - [papirus-icon-theme](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) (dark)
- Fonts: [Roboto](https://fonts.google.com/specimen/Roboto), [Fantasque Sans Mono](https://github.com/belluzj/fantasque-sans)

## Applications
- Shell: [zsh](https://www.zsh.org/)
- Terminal: [kitty](https://sw.kovidgoyal.net/kitty/index.html)
- Text editors: [vim](http://www.vim.org/), [vscode](https://code.visualstudio.com/)
- File managers: [ranger](https://github.com/ranger/ranger), [thunar](https://docs.xfce.org/xfce/thunar/start)
- Media player: [mpv](https://mpv.io/)
- Music: [tidal-hifi](https://github.com/Mastermindzh/tidal-hifi)
- Browsers: [brave](https://brave.com/), [firefox](https://www.mozilla.org/en-US/firefox/)
- Screenshot tool: [hyprshot](https://github.com/Gustash/Hyprshot)
- AUR helper: [yay](https://github.com/Jguer/yay)

# Dotfiles manager
To manage both my user and system level dotfiles, I use [Dotdrop by deadc0de6](https://github.com/deadc0de6/dotdrop).

To install these dotfiles, use the following commands from within the root of the repo.  
For more information, consult the excellent [documentation](https://dotdrop.readthedocs.io/en/latest/usage/#install-dotfiles).
```bash
git submodule update --init --recursive

dotdrop --cfg="config-user.yml" install
sudo dotdrop --cfg="config-system.yml" install
```

To install dotdrop, either use the submodule in this repo, and then use `dotdrop.sh`.
```bash
python3 -m pip install --user -r dotdrop/requirements.txt
./dotdrop/bootstrap.sh

# Use dotdrop
./dotdrop.sh --cfg="config-user.yml" compare
```

Or you could install the [AUR dotdrop package](https://aur.archlinux.org/packages/dotdrop), and just use `dotdrop` like in the examples above.


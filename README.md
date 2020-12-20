# Dotfiles [![Build Status](https://travis-ci.com/niraami/dotfiles.svg?branch=master)](https://travis-ci.com/niraami/dotfiles)
Dotfiles - synonym for: *I'm never using linux again If I lose these files*.

This might be a bit of a strange dotfiles setup, but I'm doing everything in a way, that If I wanted to reinstall, I could do it in < 1 hour. Though this means, that these dotfiles install pretty much all of my essential apps, dependencies & their respective configs.


## Specs (deps)
*these need a bit of a cleanup*

**distro**: [Arch Linux](https://www.archlinux.org/)  
**wm**: [i3-gaps](https://github.com/Airblader/i3)  
**shell**: [zsh](https://www.zsh.org/) + [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) + [p10k](https://github.com/romkatv/powerlevel10k) + plugins  
**terminal**: [urxvt](https://github.com/exg/rxvt-unicode) (rxvt-unicode)  
**editor**: [vim](https://github.com/vim/vim) (via gvim package)  
**file manager**: [ranger](https://github.com/ranger/ranger) + [w3m](https://github.com/tats/w3m)  
**status bar**: [polybar](https://github.com/polybar/polybar) + [material-design-icons](https://github.com/google/material-design-icons) + [fantasque-sans-mono](https://github.com/belluzj/fantasque-sans)  
**compositor**: [picom](https://github.com/ibhagwan/picom)  
**launcher**: [rofi](https://github.com/davatorium/rofi)  
**notification daemon**: [deadd notification center ](https://github.com/phuhl/linux_notification_center)(linux-notification-center)  
**automount daemon**: [udevil](https://github.com/IgnorantGuru/udevil) ([devmon](https://github.com/bonomani/devmon))  
**screenshot utility**: [flameshot](https://github.com/flameshot-org/flameshot)  
**spotify skin**: [dribbblish](https://github.com/morpheusthewhite/spicetify-themes/tree/master/Dribbblish) (*dracula* color-scheme)  
**keyring manager**: [gnome-keyring](https://wiki.gnome.org/Projects/GnomeKeyring) + [seahorse](https://wiki.gnome.org/Apps/Seahorse)  
**mail client**: [mailspring](https://getmailspring.com/)  

*All of these dependencies (and more) are automatically installed, see the [installation section](#Installation)*  

## Screenshots
Coming soon™

## Installation
*Please backup any of your previous configuration, the installation will* ***not*** *ask your permission to replace/delete any of your local files*.

After cloning, just run the `install` script. It's quite possible that it may ask for sudo permissions if there are any packages being installed, or links created outside of the `home` path.  
If you also want to install all of the optional dependencies (mostly apps), run `install -c opt.conf.yaml`.   
Same goes for spotify & it's skin, run `install -c spotify.conf.yaml`.

These dotfiles use [Dotbot](https://github.com/anishathalye/dotbot "github.com/anishathalye/dotbot") to manage the installation & [Travis-Arch](https://github.com/mikkeloscar/arch-travis "github.com/mikkeloscar/arch-travis") to make CI via Travis possible.

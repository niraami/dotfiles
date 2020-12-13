# Dotfiles [![Build Status](https://travis-ci.com/niraami/dotfiles.svg?branch=master)](https://travis-ci.com/niraami/dotfiles)
Dotfiles - synonym for: *I'm never using linux again If I lose these files*.


## Specs
**distro**: [Arch Linux](https://www.archlinux.org/)  
**wm**: [i3-gaps](https://github.com/Airblader/i3)  
**shell**: [zsh](https://www.zsh.org/) + [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) + plugins  
**terminal**: [urxvt](https://github.com/exg/rxvt-unicode) (rxvt-unicode)  
**editor**: [vim](https://github.com/vim/vim)  
**file manager**: [ranger](https://github.com/ranger/ranger) + [w3m](https://github.com/tats/w3m)  
**status bar**: [polybar](https://github.com/polybar/polybar) + [material-design-icons](https://github.com/google/material-design-icons) + [fantasque-sans-mono](https://github.com/belluzj/fantasque-sans)  
**compositor**: [picom](https://github.com/ibhagwan/picom)  
**launcher**: [rofi](https://github.com/davatorium/rofi)  
**notification daemon**: [deadd_notification_center ](https://github.com/phuhl/linux_notification_center)(linux-notification-center)  
**automount daemon**: [udevil](https://github.com/IgnorantGuru/udevil) ([devmon](https://github.com/bonomani/devmon))  
**screenshot utility**: [flameshot](https://github.com/flameshot-org/flameshot) 

*All of these dependencies (and more) are automatically installed, see [this section](#Installation)*  

## Screenshots
Coming soon™

## Installation
*Please backup any of your previous configuration, the installation will* ***not*** *ask your permission to replace/delete any of your local files*.

After cloning, just run the `install` script. It's quite possible that it may ask for sudo permissions if there are any packages being installed, or links created outside of the `home` path.
These dotfiles use [Dotbot](https://github.com/anishathalye/dotbot "github.com/anishathalye/dotbot") to manage the installation & [Travis-Arch](https://github.com/mikkeloscar/arch-travis "github.com/mikkeloscar/arch-travis") to make CI via Travis possible.

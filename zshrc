export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $HOME/.alias

export ZSH="$HOME/.oh-my-zsh"
# Move custom files to ~/.config instead of inside the oh-my-zsh repository
export ZSH_CUSTOM="$HOME/.config/oh-my-zsh"
# Move zcompdump files to ~/.cache instead of the home folder
export ZSH_COMPDUMP="$HOME/.cache/zsh/zcompdump-$HOST-$ZSH_VERSION"

export EDITOR=/usr/bin/vim
export SYSTEMD_EDITOR="$EDITOR"
export SUDO_EDITOR="$EDITOR"
export VISUAL="$EDITOR"

# Disable the `less` history file
export LESSHISTFILE=-

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  git-lfs
  archlinux
  autoupdate
  auto-notify
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# zsh-auto-notify
AUTO_NOTIFY_IGNORE+=("ranger")
export AUTO_NOTIFY_THRESHOLD=16
export AUTO_NOTIFY_EXPIRE_TIME=7000

# zsh-syntax-highlighting
#typeset -A ZSH_HIGHLIGHT_HIGHLIGHTERS
typeset -A ZSH_HIGHLIGHT_STYLES

# zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#525356,italic"

#ZSH_HIGHLIGHT_HIGHLIGHTERS=(main cursor)

#ZSH_HIGHLIGHT_STYLES[cursor]='fg=purple'
#ZSH_HIGHLIGHT_STYLES[command]='fg=cyan'
#ZSH_HIGHLIGHT_STYLES[alias]='fg=blue,bold'
#ZSH_HIGHLIGHT_STYLES[path]='fg=gray'

# fix for ZelliJ that's for some reason not playing nicely with Home & End keys
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line

# Enable ZSH corrections
setopt correct

# trap USR1 signal - this signal is called via a pacman hook to rehash completion across all ZSH instances
TRAPUSR1() { rehash }

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


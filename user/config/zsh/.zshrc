source $HOME/.shell

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$XDG_DATA_HOME/oh-my-zsh"
# Move custom files to ~/.config instead of inside the oh-my-zsh repository
export ZSH_CUSTOM="$XDG_CONFIG_HOME/oh-my-zsh"
# Move zcompdump files to ~/.cache instead of the home folder
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump-$HOST-$ZSH_VERSION"
# Move zlogin file to ~/.config instead
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
# Configure history
export HISTSIZE=100000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS


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
export AUTO_NOTIFY_URGENCY_ON_SUCCESS="low"
export AUTO_NOTIFY_URGENCY_ON_ERROR="normal"

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

eval "$(zoxide init zsh)"

# Fix for ZelliJ that's for some reason not playing nicely with Home & End keys
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line

# Enable ZSH corrections
setopt correct

# Rehash on completion
zstyle ":completion:*:commands" rehash 1
# Trap USR1 signal - this is one of the common ways of external rehashing
TRAPUSR1() { rehash }

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="${HOME}/.oh-my-zsh"
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  archlinux
  git
  auto-notify
)

source $ZSH/oh-my-zsh.sh

# zsh-auto-notify
AUTO_NOTIFY_IGNORE+=("ranger")
export AUTO_NOTIFY_THRESHOLD=8
export AUTO_NOTIFY_EXPIRE_TIME=10000

alias feh='feh -Zdr.'
alias ls='ls -la --color=auto'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

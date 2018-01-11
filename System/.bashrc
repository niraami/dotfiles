#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias sudo='sudo '
alias ls='ls --color=auto'
alias rr='ranger -r /.config/ranger/'
alias sugparted='sudo gparted'

export JAVA_HOME='/usr/lib/jvm/java-8-openjdk'

export STEAM_FRAME_FORCE_CLOSE=1
export EDITOR=vim

export QT_QPA_PLATFORMTHEME=gtk2

PS1='[\u@\h \W]\$ '


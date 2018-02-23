#
# ~/.bashrc
#

# If not running interactively, don't do anything
#[[ $- != *i* ]] && return

alias sudo='sudo ';
alias ls='ls --color=auto';
alias rr='ranger -r /.config/ranger/';
alias sugparted='sudo gparted';

export JAVA_HOME='/usr/lib/jvm/java-8-openjdk';

export STEAM_FRAME_FORCE_CLOSE=1;
export EDITOR=vim;

export QT_QPA_PLATFORMTHEME=gtk2;

export GPU_FORCE_64BIT_PTR=0;
export GPU_MAX_HEAP_SIZE=100;
export GPU_USE_SYNC_OBJECTS=1;
export GPU_MAX_ALLOC_PERCENT=100;
export GPU_SINGLE_ALLOC_PERCENT=100;

PS1='[\u@\h \W]\$ '


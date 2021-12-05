#!/usr/bin/env zsh

mkdir ~/.config/discord-parallel
mkdir /tmp/discord-parallel
/bin/zsh -c "export XDG_CONFIG_HOME=~/.config/discord-parallel; export TMPDIR=/tmp/discord-parallel; /opt/discord/Discord $@"

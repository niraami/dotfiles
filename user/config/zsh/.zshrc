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

# Manpage color
# see: https://gist.github.com/bahamas10/542875bb47990933638d2b7dfaa501bf
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;33;44m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[4;1;32m'
export LESS_TERMCAP_mr=$'\e[7m'
export LESS_TERMCAP_mh=$'\e[2m'
export LESS_TERMCAP_ZN=$'\e[74m'
export LESS_TERMCAP_ZV=$'\e[75m'
export LESS_TERMCAP_ZO=$'\e[73m'
export LESS_TERMCAP_ZW=$'\e[75m'
export MANPAGER='less'

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

hevc() {
  local q=${HEVC_Q:-22} f out tmp fps lang start rc scodec i
  local -a vopts sopts
  for f in "$@"; do
    out="${f:r}.hevc.mkv"
    if [[ -e $out ]]; then print -u2 "hevc: exists, skipping: $out"; continue; fi
    tmp=$(mktemp -d "${f:h}/.hevc.XXXXXX") || return 1
    # mov_text subs can't be muxed into Matroska; transcode just those to SRT
    # and copy the rest through. '0:V' skips cover-art/thumbnail video tracks.
    sopts=(); i=0
    for scodec in ${(f)"$(ffprobe -v error -select_streams s -show_entries stream=codec_name -of csv=p=0 "$f")"}; do
      [[ $scodec == mov_text ]] && sopts+=(-c:s:$i srt) || sopts+=(-c:s:$i copy)
      ((++i))
    done
    # Mesa's radeonsi VAAPI encoder emits its own in-band VPS/SPS/PPS that differ
    # from the hvcC ffmpeg writes into the container. Round-trip the video through
    # mkvextract/mkvmerge so the container headers are rebuilt from the bitstream.
    env LIBVA_DRIVER_NAME=radeonsi ffmpeg -loglevel warning -stats \
      -init_hw_device vaapi=va:/dev/dri/renderD128 -filter_hw_device va \
      -i "$f" -map '0:V' -map '0:a?' -map '0:s?' -vf 'format=p010le,hwupload' \
      -c:v hevc_vaapi -profile:v main10 -level 5.1 -rc_mode CQP -global_quality "$q" \
      -c:a copy "${sopts[@]}" "$tmp/enc.mkv" \
    && mkvextract -q "$tmp/enc.mkv" tracks "0:$tmp/v.hevc" \
    && {
      fps=$(ffprobe -v error -select_streams v:0 -show_entries stream=r_frame_rate -of csv=p=0 "$tmp/enc.mkv")
      start=$(ffprobe -v error -select_streams v:0 -show_entries stream=start_pts -of csv=p=0 "$tmp/enc.mkv")
      lang=$(ffprobe -v error -select_streams v:0 -show_entries stream_tags=language -of csv=p=0 "$tmp/enc.mkv")
      vopts=(--default-duration "0:${fps}p" --sync "0:${start:-0}")
      [[ -n $lang ]] && vopts+=(--language "0:$lang")
      mkvmerge -q -o "$out" "${vopts[@]}" "$tmp/v.hevc" --no-video "$tmp/enc.mkv"
    }
    rc=$?
    rm -rf "$tmp"
    if (( rc )); then print -u2 "hevc: failed ($rc): $f"; return $rc; fi
  done
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

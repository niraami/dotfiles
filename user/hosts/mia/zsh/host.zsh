# Host-specific zsh config for mia, deployed as $ZDOTDIR/host.zsh and sourced
# by .zshrc when present

# Transcode to 10-bit HEVC on the Radeon's VAAPI encoder
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

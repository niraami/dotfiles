get_album() {
  echo $(ffprobe "$Song" 2>&1 | grep -A20 'Metadata:' | grep -i 'album  ' | awk -F':' '{print $2}');
}

for Song in ./*; do
  if [ -d "$Song" ]; then continue; fi;
  album="$(get_album | sed 's\ \_\g')";
  if [ ! -d "./$album" ]; then
    mkdir "./$album";
  fi;
  mv "$Song" "./$album/";
done;

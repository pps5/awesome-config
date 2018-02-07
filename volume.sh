volume=`amixer get Master |\
grep -E 'Playback.*([0-9]?[0-9]?[0-9])%\].*' -o |\
head -n 1`
notify-send "$volume" -t 800

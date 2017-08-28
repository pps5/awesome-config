status=`amixer get Master | grep -E ".*\[on\].*"`
if [ -n "$status" ]; then
    amixer sset Master mute
else
    amixer sset Master unmute
fi

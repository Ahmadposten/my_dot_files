#!/bin/sh

BACKLIGHT_INTERFACE=intel_backlight
STEP=10
ICON="<fn=3>☼</fn>"
PIPE=$XDG_RUNTIME_DIR/brightness-display
[ -p "$PIPE" ] || mkfifo "$PIPE"

if [ $# -eq 1 ]; then
    case $1 in
       "up")   do=inc ;;
       "down") do=dec ;;
       *)      echo "Invalid option"; exit ;;
    esac
fi

xbacklight -time 0 -$do $STEP

current=$(cat /sys/class/backlight/$BACKLIGHT_INTERFACE/brightness)
max=$(cat /sys/class/backlight/$BACKLIGHT_INTERFACE/max_brightness)
percent=$(echo "$current * 100 / $max" | bc -l | cut -d '.' -f 1)
level="$($HOME/.xmonad/vbar.sh $percent)"

echo $current
notify-send -r 98 -h int:value:$percent "Screen Brightness"
echo "$ICON" "$level" > "$PIPE"

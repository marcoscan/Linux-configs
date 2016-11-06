#!/bin/bash

a="Time to empty battery:"
b=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | perl -lane 'print $F[3], " ",  $F[4] if /time/')
c="  $a $b  "
yad --title="You chose..." --text="$c "

# old one
#upower -i /org/freedesktop/UPower/devices/battery_BAT0 | perl -lane 'print $F[3], " ",  $F[4] if /time/' | gxmessage -buttons "Close:1" -default "Close" -geometry 500x200 -center -font "DejaVu Sans Mono 8" -wrap -title "Todo" -file -

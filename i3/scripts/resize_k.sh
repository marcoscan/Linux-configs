#!/bin/sh
# kudos to http://pushl.net/blog/18/

# shrink top window
eval i3-msg $*
HERE=`xdotool getwindowfocus`

ULX=`xwininfo -id $HERE | grep "  Absolute upper-left X:" | awk '{print $4}'`
ULY=`xwininfo -id $HERE | grep "  Absolute upper-left Y:" | awk '{print $4}'`

# If there is no window, ULX == 1 and ULY == 1.
if [ $ULX != "-1" -o $ULY != "-1" ]; then
	if [[ $ULY -gt 36 ]]; then	
		i3-msg "focus up" && i3-msg "resize shrink height 5 px or 5 ppt" && i3-msg "focus down"
	else
		i3-msg "resize shrink height 5 px or 5 ppt"
	fi
fi

#!/bin/bash

(sleep 1 && xmodmap ~/.Xmodmap) &
(sleep 2 && remind -z -k'gxmessage -title "reminder" %s &' ~/.reminders &) &
xrdb ~/.Xresources
setxkbmap -option caps:escape
sh ~/.fehbg &
#(sleep 12 && setxkbmap -layout it)
(sleep 6 && setxkbmap -layout it)
(sleep 2 && conky -c /home/marco/.config/bspwm/conkyrc-todo)

# not needed here, just for testing
#export PANEL_FIFO=/tmp/panel-fifo

sxhkd &
#sh /home/marco/.config/bspwm/wm
exec bspwm

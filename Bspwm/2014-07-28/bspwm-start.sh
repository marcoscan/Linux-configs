#!/bin/bash

(sleep 1 && xmodmap ~/.Xmodmap) &
(sleep 2 && remind -z -k'gxmessage -title "reminder" %s &' ~/.reminders &) &
xrdb ~/.Xresources
setxkbmap -option caps:escape
sh ~/.fehbg &

(sleep 6 && setxkbmap -layout it)
(sleep 1 && conky -c /home/marco/.config/bspwm/conkyrc-todo)

sxhkd &

exec bspwm

#!/bin/bash

(sleep 1 && xmodmap ~/.Xmodmap) &
(sleep 2 && remind -z -k'gxmessage -title "reminder" %s &' ~/.reminders &) &
xrdb ~/.Xresources
setxkbmap -option caps:escape
sh ~/.fehbg &

(sleep 6 && setxkbmap -layout it)
(sleep 1 && conky -c /home/marco/.config/bspwm/conkyrc-todo)

sxhkd &

(sleep 6 && cat $WIN_FIFO | awk -F /Smar/ '{ system("if [ $(bspc query -W -d | wc -l) -le 1 ] ; then bspc desktop --layout monocle ; exit 1; fi "); }') &

exec bspwm

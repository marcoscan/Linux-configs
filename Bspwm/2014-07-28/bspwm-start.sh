#!/bin/bash

(sleep 1 && xmodmap ~/.Xmodmap) &
(sleep 2 && remind -z -k'gxmessage -title "reminder" %s &' ~/.reminders &) &
xrdb ~/.Xresources
setxkbmap -option caps:escape
sh ~/.fehbg &

(sleep 6 && setxkbmap -layout it)
(sleep 1 && conky -c /home/marco/.config/bspwm/conkyrc-todo)

#(sleep 1 && test -p /tmp/win.fifo || mkfifo /tmp/win.fifo) &
#(sleep 3 && sh ~/.config/bspwm/Scripts/bspwm-wins.sh) &
#(sleep 2 && bspc control --subscribe > /tmp/win.fifo) &

#(sleep 6 && cat /tmp/win.fifo  | awk -F /Ltiled/ '{ exit(system("if [ $(bspc query -W -d | wc -l) -le 1 ] ; then bspc desktop --layout monocle ; exit 1; fi ")); }') &

sxhkd &

exec bspwm

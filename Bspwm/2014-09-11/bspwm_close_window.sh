#! /bin/bash

while true; do

if [ $(bspc query -W -d | wc -l) -eq 2 ] ; then
#bspc window -c
bspc window -c
bspc desktop --layout monocle
bspc config focused_border_color "#303030"
        exit 1
else
bspc window -c

       exit 1
fi

done

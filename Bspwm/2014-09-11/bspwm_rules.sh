#! /bin/bash

while true; do

if [ $(bspc query -W -d | wc -l) -ne 0 ] ; then

bspc desktop --layout tiled
bspc config focused_border_color "#AFD700"
        exit 1
else

bspc config focused_border_color "#303030"
       exit 1
fi

done

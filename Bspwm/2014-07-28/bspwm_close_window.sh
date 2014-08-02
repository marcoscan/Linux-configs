#! /bin/bash

while true; do

if [ $(bspc query -W -d | wc -l) -eq 2 ] ; then

bspc window -c
bspc desktop --layout monocle
        exit 1
else
bspc window -c

       exit 1
fi

done

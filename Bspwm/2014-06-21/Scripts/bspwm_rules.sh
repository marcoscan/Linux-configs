#! /bin/bash

# quick hack to remove window borders when there's only one window open; other ways? :-)

while true; do

if [ $(bspc query -W -d | wc -l) -ne 0 ] ; then

bspc desktop --layout tiled
        exit 1
else

bspc desktop --layout monocle
       exit 1
fi

done

#! /bin/bash

TEXT=" Add a Todo item"

entry=$(yad --text="$TEXT" --center --width 500 --entry --title " Add a Todo item" \
    --button="gtk-close:1" \
    --button="Edit Todo:2" --button="gtk-ok:0" \
    --text " Add a Todo item" \
     --entry --editable)
choice=$?

[[ $choice -eq 1 ]] && exit 0

if [[ $choice -eq 2 ]]; then
    gvim ~/Todo/general_todo.txt
    exit 0
fi

case $entry in
    http://*|https://*|ftp://*)
        { echo ""; echo $entry; } >> ~/Todo/general_todo.txt &
        ;;
    *) exit 1 ;;    
esac

exit 0

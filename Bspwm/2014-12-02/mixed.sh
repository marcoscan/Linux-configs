#!/bin/bash

clear
set -e

function trans_sec {
   local D1=$1
   local D2=$2
   ((diff_sec=D1-D2))
   echo - | awk '{printf "%02d:%02d","'"$diff_sec"'"%(60*60)/60,"'"$diff_sec"'"%60}'
}

function progress_bar {
   local i
   local varTime=$1
   local whatTime=$2
   local desired=$(date -d"$varTime minutes" +'%s')
   local current
   i=0
   while [ $i -le $((varTime * 60)) ]
   do
      echo $((i * 1/varTime * 100/60))
      i=$((i+1))
      current=$(date +'%s')
      echo "# $whatTime $(trans_sec desired current) "
      if [ $i -eq $((varTime * 60)) ]
      then
         sleep 1
      fi
      sleep 1
   done  | yad --undecorated --width 400 --center  --progress
}

function pomodoro {
    pomodoro_time=30
    progress_bar $pomodoro_time ""
    exit 0
}

function additem {
    item=$(yad --width=400 --title "Test Form" --form --field "Todo")
    entry=$(echo $item | awk 'BEGIN {FS="|" } { print $1 }')
    { echo ""; echo $entry; } >> ~/Todo/general_todo.txt &
     exit 0
}

function bookmark { 
    date=$(date +%d-%m-%Y)
    item=$(yad  --width=400 --title "Test Form" --form --field "Link" --field "Descrizione")
    entry=$(echo $item | awk 'BEGIN {FS="|" } { print $1 }')
    description=$(echo $item | awk 'BEGIN {FS="|" } { print $2 }')
    entry2=$(echo "<div><p>$date</p><p><a target='_blank' href='$entry'>$entry</a></p><p>$description</p></div>")
    sed -i "/<\/body>/i\ $entry2" ~/Todo/desktop-bookmarks.htm &
exit 0
}

answer=$(yad --width=400 --height=150 --list --separator='' --multiple --column "Menu" "Pomodoro" "Todo" "Desktop Bookmark")

   case $answer in
   Pomo*)
      pomodoro   ;;
   Todo*)
      additem   ;;
   Des*)
      bookmark   ;;
   *) break ;;
   esac

exit 0

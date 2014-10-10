#!/bin/bash
# kudos to https://github.com/tiagocampo/zepomo-indicator

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
         #beep -r 10 -f 1500 -l 200 -d 1000
         sleep 1
         #beep -f 1500 -l 2000
      fi
      sleep 1
   done  | yad --undecorated --width 300 --center  --progress
}

POMODORO_TIME=30
progress_bar $POMODORO_TIME ""
exit 0

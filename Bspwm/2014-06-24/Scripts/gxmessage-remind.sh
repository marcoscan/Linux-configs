#!/bin/bash

remind -n ~/.reminders | sed 's/\(....\).\(..\).\(..\)/\3-\2-\1/' | sed G | gxmessage -buttons "Close:1" -default "Close" -center -geometry 560 -font "DejaVu Sans 8" -wrap -title "Todo" -file -

#!/bin/bash

cal -3 | gxmessage -buttons "Close:1" -default "Close" -geometry 500x200 -center -font "DejaVu Sans Mono 8" -wrap -title "Todo" -file -

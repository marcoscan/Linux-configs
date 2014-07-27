#!/bin/bash

if [[ -s $FILE ]] ; then
echo "Niente in programma"
else
reminders=$(remind -n ~/.reminders | sort -u | sed 's/\(....\).\(..\).\(..\)/\3-\2-\1/' | sed G)
echo "$reminders"
fi ;

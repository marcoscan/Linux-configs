#!/bin/sh
cd ~/Todo
general_todo="general_todo.txt"
cat "$general_todo"
echo ""
filename="daily_todo_"`eval date +%Y-%m-%d`".txt"
if [[ -f $filename ]] ; then
cat "$filename"
else
echo "Niente in programma"
fi ;

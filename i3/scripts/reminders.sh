#!/bin/bash
# nedded by conkyrc-todo

# reminders.sh
# copyright 2010 by Mobilediesel
#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.

#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.

#You should have received a copy of the GNU General Public License
#along with this program.  If not, see <http://www.gnu.org/licenses/>.

#reminders=$(remind -h | fold -sw55 | sed -e "s/.*(today):/\${color grey}&\${color 99ccff}/" -e '/^$/d')

if [[ -s $FILE ]] ; then
#echo "Niente in programma"
echo ""
else
reminders=$(remind -n ~/.reminders | sort -u | sed 's/\(....\).\(..\).\(..\)/\3-\2-\1/' | sed G)
echo "$reminders"
fi ;

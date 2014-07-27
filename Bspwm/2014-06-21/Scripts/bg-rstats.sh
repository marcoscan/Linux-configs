#!/bin/sh
Rscript ~/.config/bspwm/Scripts/background.R
sleep 3

convert ~/.config/bspwm/Background/Rplot.jpeg ~/.config/bspwm/Background/stats-june.png -geometry +640+610 -compose over -composite ~/.config/bspwm/Background/bspwmbg.jpg
feh --bg-scale ~/.config/bspwm/Background/bspwmbg.jpg

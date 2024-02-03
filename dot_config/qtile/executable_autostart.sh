#!/bin/bash

# Swap left alt and left ctrl
setxkbmap -option ctrl:swap_lalt_lctl
setxkbmap fr

# xinput to find the id of the touchpad (in my case 11)
# xinput list-props 11 (to find the id of the property to change, in my case 352) 
# enable tap to click
xinput set-prop 11 352 1
# enable natural scrolling
xinput set-prop 11 325 1


# ~/.screenlayout/home-dual-monitor.sh &
~/.screenlayout/home-single-benq-monitor.sh &
# sxhkd &

# picom &
# Launch polybar
# ~/.config/polybar/launch.sh &
# polybar -r mybar -c ~/.config/polybar/config.ini &

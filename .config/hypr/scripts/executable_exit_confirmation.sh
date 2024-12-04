#!/bin/bash

# Use zenity for a graphical confirmation dialog
if zenity --question --text="Are you sure you want to exit Hyprland?" --no-wrap; then
    hyprctl dispatch exit
else
    echo "Exit cancelled"
fi

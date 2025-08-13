#!/bin/bash
if pgrep -x hypridle > /dev/null; then
    killall hypridle
    notify-send "            Hypridle stopped"
else
    hypridle &
    notify-send "            Hypridle started"
fi

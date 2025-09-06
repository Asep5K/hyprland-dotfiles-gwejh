#!/usr/bin/env bash

f="/var/lib/AccountsService/icons/$USER"

if pgrep -x hypridle > /dev/null; then
    killall hypridle
    notify-send -i "$f" -a "hyprstop" "Hypridle stopped"
else
    hypridle &
    notify-send -i "$f" -a "hyprstart" "Hypridle started"
fi

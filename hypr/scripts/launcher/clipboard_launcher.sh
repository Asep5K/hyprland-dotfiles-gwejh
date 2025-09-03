#!/usr/bin/env bash

thm="$HOME/.config/rofi/themes/spotlight.rasi"

if pidof rofi > /dev/null; then
    pkill rofi
fi

cliphist list | rofi -dmenu -p -theme "$thm" "Clipboard" | cliphist decode | wl-copy

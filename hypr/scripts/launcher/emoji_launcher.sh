#!/usr/bin/env bash

thm="$HOME/.config/rofi/themes/spotlight.rasi"

if pidof rofi > /dev/null; then
    pkill rofi
fi

rofi -show emoji -theme "$thm"





#!/usr/bin/env bash

thm="$HOME/.config/rofi/themes/spotlight.rasi"
f="/var/lib/AccountsService/icons/$USER"

rofi_check() {
    if pgrep -x  rofi > /dev/null; then
    pkill -x rofi
    fi
}

rofi() {
    case "$1" in
        Emoji)
        rofi_check
        exec rofi -show emoji -theme "$thm"
            ;;
        Clipboard)
        rofi_check
        exec cliphist list | rofi -dmenu -p -theme "$thm" "Clipboard" | cliphist decode | wl-copy12
            ;;
     esac
}

case "$1" in 
    Emoji|Clipboard) rofi "$1" ;;
esac
#!/usr/bin/env bash

f="/var/lib/AccountsService/icons/$USER"

# Toggle DND
if makoctl mode | grep -q "do-not-disturb"; then
    notify-send -i "$f" "Mode DND Off"
    makoctl mode -r do-not-disturb
else
    notify-send -i "$f" "Mode DND On"
    sleep 3
    makoctl mode -a do-not-disturb
fi


#!/bin/bash

# Loop terus untuk update volume setiap 0.5 detik
while true; do
    vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%.0f", $2 * 100}')
    mute=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo true || echo false)

    if [ "$mute" = true ]; then
        icon="󰖁"
    else
        icon="󰕾"
    fi

    eww update get_vol="$vol"
    eww update volico="$icon"
    sleep 0.5
done

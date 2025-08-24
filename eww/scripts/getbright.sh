#!/bin/bash

# Ambil brightness
bri=$(brightnessctl get)
max=$(brightnessctl max)
bri_percent=$(( 100 * bri / max ))

# Update icon sesuai brightness (contoh)
if [ "$bri_percent" -eq 0 ]; then
    /usr/bin/eww update brico="󰃞"  # icon mati/0%
else
    /usr/bin/eww update brico="󰃠"  # icon menyala
fi

/usr/bin/eww update get_bri="$bri_percent"

# Watch perubahan brightness
while true; do
    new_bri=$(brightnessctl get)
    new_percent=$(( 100 * new_bri / max ))
    if [ "$new_percent" -ne "$bri_percent" ]; then
        bri_percent=$new_percent
        if [ "$bri_percent" -eq 0 ]; then
            /usr/bin/eww update brico="󰃞"
        else
            /usr/bin/eww update brico="󰃠"
        fi
        /usr/bin/eww update get_bri="$bri_percent"
    fi
    sleep 0.2
done

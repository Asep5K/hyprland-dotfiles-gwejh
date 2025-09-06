#!/usr/bin/env bash

BAT_PATH="/sys/class/power_supply/BAT0"

if [ -d "$BAT_PATH" ]; then
    battery_percentage=$(cat "$BAT_PATH/capacity")
    battery_status=$(cat "$BAT_PATH/status")

    battery_icons=("󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹" "󰁹")
    charging_icon="󰂄"

    icon_index=$((battery_percentage / 10))
    battery_icon=${battery_icons[icon_index]}

    if [ "$battery_status" = "Charging" ]; then
        battery_icon="$charging_icon"
    fi

    echo "$battery_percentage% $battery_icon"
else
    # Laptop tanpa baterai → kasih icon plug/AC
    ac_icon="⚡"   # icon plug/AC
    echo "$ac_icon Ac"
fi

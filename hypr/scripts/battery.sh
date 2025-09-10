#!/usr/bin/env bash

# ██████╗  █████╗ ████████╗████████╗███████╗██████╗ ██╗   ██╗
# ██╔══██╗██╔══██╗╚══██╔══╝╚══██╔══╝██╔════╝██╔══██╗╚██╗ ██╔╝
# ██████╔╝███████║   ██║      ██║   █████╗  ██████╔╝ ╚████╔╝ 
# ██╔══██╗██╔══██║   ██║      ██║   ██╔══╝  ██╔══██╗  ╚██╔╝  
# ██████╔╝██║  ██║   ██║      ██║   ███████╗██║  ██║   ██║   
# ╚═════╝ ╚═╝  ╚═╝   ╚═╝      ╚═╝   ╚══════╝╚═╝  ╚═╝   ╚═╝   

BAT_PATH="/sys/class/power_supply/BAT0"

if [ -d "$BAT_PATH" ]; then
    battery_percentage=$(cat "$BAT_PATH/capacity" 2>/dev/null || echo 0)
    battery_status=$(cat "$BAT_PATH/status" 2>/dev/null || echo "Unknown")

    battery_icons=("󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹" "󰁹")
    charging_icon="󰂄"
    ac_icon="⚡"

    # tentuin index ikon (0–10)
    icon_index=$((battery_percentage / 10))
    battery_icon=${battery_icons[$icon_index]}

    if [ "$battery_status" = "Charging" ]; then
        echo "$battery_percentage% $charging_icon"
    elif [ "$battery_status" = "Unknown" ]; then
        echo "$ac_icon AC"
    else
        echo "$battery_percentage% $battery_icon"
    fi
else
    # Laptop tanpa baterai sama sekali / pc
    ac_icon="⚡"
    echo "$ac_icon PC"
fi

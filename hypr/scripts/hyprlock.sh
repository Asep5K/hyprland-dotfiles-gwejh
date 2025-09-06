#!/usr/bin/env bash

f="/var/lib/AccountsService/icons/$USER"

ANITEXT="$HOME/.config/hypr/scripts/text_animation/anitext.sh"
WEATHER="$HOME/.config/hypr/scripts/weather/weather.sh"
# BATT="$HOME/.config/hypr/scripts/battery.sh"
# jalankan hiburan di background
"$ANITEXT" &
PID_ANITEXT=$!
"$WEATHER" &
PID_WEATHER=$!

# simpan PID untuk safety (opsional)
echo "$PID_ANITEXT $PID_WEATHER" > /tmp/hypr_if_pids

# jalankan hyprlock
pidof hyprlock >/dev/null || hyprlock

# setelah hyprlock keluar, otomatis kill hiburan
kill $PID_ANITEXT $PID_WEATHER 2>/dev/null
rm -f /tmp/hypr_if_pids

notify-send -i "$f" "Welcome back" "$USER"

#!/bin/bash

# Direktori wallpaper
WALLPAPER_DIR="$HOME/.config/hypr/wallpaper"

# Ambil satu wallpaper acak
RANDOM_WALL=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

# List efek transisi yang didukung
TRANSITIONS=("grow" "center" "outer" "wipe")

# Ambil satu efek transisi acak
RANDOM_TRANSITION=$(shuf -n 1 -e "${TRANSITIONS[@]}")

# Ganti wallpaper dengan efek transisi acak
swww img "$RANDOM_WALL"  --transition-type "$RANDOM_TRANSITION" --transition-fps 60 --transition-duration 0.5

# notify-send "Wallpaper Changed!" "$(basename "$RANDOM_WALL") | Effect: $RANDOM_TRANSITION"

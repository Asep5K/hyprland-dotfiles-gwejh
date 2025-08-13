#!/bin/bash

wallpapersDir="$HOME/.config/hypr/wallpaper"
wallpapers=("$wallpapersDir"/*)

if [ ${#wallpapers[@]} -eq 0 ]; then
    echo "Tidak ada wallpaper di folder."
    exit 1
fi

# File untuk simpan index animasi terakhir
indexFile="$HOME/.cache/last_transition_index"

# Baca index dari file, kalau gak ada mulai dari 0
if [ -f "$indexFile" ]; then
    transitionIndex=$(cat "$indexFile")
else
    transitionIndex=0
fi

transitions=("grow" "center" "outer" "wipe")
transitionCount=${#transitions[@]}

# Ambil animasi sesuai index
transitionType=${transitions[$transitionIndex]}

# Ganti wallpaper random
wallpaperIndex=$(( RANDOM % ${#wallpapers[@]} ))
selectedWallpaper="${wallpapers[$wallpaperIndex]}"

swww img "$selectedWallpaper" --transition-type="$transitionType" --transition-duration=0.5

# Update index dan simpan kembali ke file (loop ulang)
transitionIndex=$(( (transitionIndex + 1) % transitionCount ))
echo "$transitionIndex" > "$indexFile"

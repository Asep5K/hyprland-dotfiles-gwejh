#!/bin/bash

# swww-daemon
wallpapersDir="$HOME/.config/hypr/wallpaper"
wallpapers=("$wallpapersDir"/*)

if [ ${#wallpapers[@]} -eq 0 ]; then
    echo "Tidak ada wallpaper di folder."
    exit 1
fi

# File untuk simpan index animasi & wallpaper terakhir
indexFile="$HOME/.cache/last_index"

# Baca index dari file, kalau gak ada mulai dari 0
if [ -f "$indexFile" ]; then
    read transitionIndex wallpaperIndex < "$indexFile"
else
    transitionIndex=0
    wallpaperIndex=0
fi

transitions=("grow" "outer" "wipe" "center" "wipe")
transitionCount=${#transitions[@]}
wallpaperCount=${#wallpapers[@]}

# Ambil animasi & wallpaper sesuai index
transitionType=${transitions[$transitionIndex]}
selectedWallpaper="${wallpapers[$wallpaperIndex]}"

swww img "$selectedWallpaper" --transition-type "$transitionType"  --transition-fps 60 --transition-duration=0.5

# Update index dan simpan kembali ke file (loop ulang)
transitionIndex=$(( (transitionIndex + 1) % transitionCount ))
wallpaperIndex=$(( (wallpaperIndex + 1) % wallpaperCount ))

echo "$transitionIndex $wallpaperIndex" > "$indexFile"

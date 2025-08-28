#!/bin/bash

# 📂 Folder wallpaper
wallpapersDir="$HOME/Pictures/Wallpaper"
wallpapers=("$wallpapersDir"/*)

if [ ${#wallpapers[@]} -eq 0 ]; then
    echo "Tidak ada wallpaper di folder."
    exit 1
fi

# 📄 File index cache
indexFile="$HOME/.cache/last_index"

# 🎬 Daftar animasi
transitions=("grow" "outer" "wipe" "center" "wipe")
transitionCount=${#transitions[@]}
wallpaperCount=${#wallpapers[@]}

# 🔧 Fungsi ganti wallpaper sekali
change_wallpaper() {
    if [ -f "$indexFile" ]; then
        read transitionIndex wallpaperIndex < "$indexFile"
    else
        transitionIndex=0
        wallpaperIndex=0
    fi

    transitionType=${transitions[$transitionIndex]}
    selectedWallpaper="${wallpapers[$wallpaperIndex]}"

    swww img "$selectedWallpaper" \
        --transition-type "$transitionType" \
        --transition-fps 60 \
        --transition-duration=0.5

    transitionIndex=$(( (transitionIndex + 1) % transitionCount ))
    wallpaperIndex=$(( (wallpaperIndex + 1) % wallpaperCount ))

    echo "$transitionIndex $wallpaperIndex" > "$indexFile"
}

# 🔄 Mode daemon (loop)
daemon_mode() {
    interval=${1:-300} # default 300 detik = 5 menit
    while true; do
        change_wallpaper
        sleep "$interval"
    done
}

# 🛠️ Main: cek argumen
case "$1" in
    daemon)
        daemon_mode "$2" # contoh: ./script.sh daemon 120 (tiap 2 menit)
        ;;
    next)
        change_wallpaper # ganti sekali (buat keybind)
        ;;
    *)
        echo "Usage: $0 {daemon [detik]|next}"
        ;;
esac

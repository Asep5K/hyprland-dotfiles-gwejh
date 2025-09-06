#!/usr/bin/env bash

thm=$HOME/.config/rofi/themes/wall.rasi

if pidof rofi > /dev/null; then
    pkill rofi
fi

wallpapers_dir="$HOME/Pictures/Wallpaper"

selected_wallpaper=$(for a in "$wallpapers_dir"/*; do
    # tampilkan nama aja di menu, tapi simpan path full di info
    echo -en "$(basename "${a%.*}")\0icon\x1f$a\x00info\x1f$a\n"
done | rofi -dmenu -p " " -format i -theme "$thm")

[ -z "$selected_wallpaper" ] && exit 0

# ambil path full berdasarkan index pilihan
all_files=("$wallpapers_dir"/*)
selected_path="${all_files[$selected_wallpaper]}"

swww img "$selected_path" --transition-type any --transition-duration 2

wal -i "$selected_path" 

$HOME/.config/hypr/scripts/mako.sh
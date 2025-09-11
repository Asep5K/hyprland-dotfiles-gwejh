#!/usr/bin/env bash

# ██╗    ██╗ █████╗ ██╗     ██╗     ██████╗  █████╗ ██████╗ ███████╗██████╗ 
# ██║    ██║██╔══██╗██║     ██║     ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗
# ██║ █╗ ██║███████║██║     ██║     ██████╔╝███████║██████╔╝█████╗  ██████╔╝
# ██║███╗██║██╔══██║██║     ██║     ██╔═══╝ ██╔══██║██╔═══╝ ██╔══╝  ██╔══██╗
# ╚███╔███╔╝██║  ██║███████╗███████╗██║     ██║  ██║██║     ███████╗██║  ██║
#  ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝
# ███████╗███████╗██╗     ███████╗ ██████╗████████╗ ██████╗ ██████╗ 
# ██╔════╝██╔════╝██║     ██╔════╝██╔════╝╚══██╔══╝██╔═══██╗██╔══██╗
# ███████╗█████╗  ██║     █████╗  ██║        ██║   ██║   ██║██████╔╝
# ╚════██║██╔══╝  ██║     ██╔══╝  ██║        ██║   ██║   ██║██╔══██╗
# ███████║███████╗███████╗███████╗╚██████╗   ██║   ╚██████╔╝██║  ██║
# ╚══════╝╚══════╝╚══════╝╚══════╝ ╚═════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝

thm="$HOME/.config/rofi/themes/wall.rasi"
thm2="$HOME/.config/rofi/themes/power_menu.rasi"

rofi_check() {
    if pidof rofi > /dev/null; then
        pkill rofi
    fi
}

# Utility
prepare_env() {
    pgrep -x swww-daemon > /dev/null || (swww-daemon & disown)
    pkill -x mpvpaper 2> /dev/null
}

mpvpaper_check() {
    if pgrep -x mpvpaper > /dev/null; then
     pkill -x mpvpaper
    fi
}

rofi_cmd() {
    rofi -dmenu -p " " -format i -theme "$thm"
}

update_mako() {
    # Ambil warna accent dari pywal
    BORDER=$(sed -n '12p' ~/.cache/wal/colors)

    # Ganti border-color global (sebelum [app-name=...])
    sed -i "0,/^\[app-name=/ s/^border-color=.*/border-color=$BORDER/" ~/.config/mako/config

    # Reload mako supaya langsung berubah
    pkill -USR1 mako
}
update_hyprlock() {
    local path="$1"
    local lock_conf="$HOME/.config/hypr/hyprlock.conf"

    [ -f "$lock_conf" ] || return 0

    # pakai sed untuk ganti line path di blok background
    sed -i "/^background{/,/}/{
        /^\s*path = /c\\
    path = $path
    }" "$lock_conf"
}


# Fungsi utama, pilih tipe: foto/video/next
wallpaper_manager() {
    type="$1"      # foto/video/next
    interval="$2"  # optional untuk daemon


    case "$type" in
        foto|next)
        rofi_check
            dir="$HOME/Pictures/Wallpaper"
            files=("$dir"/*)
            [ ${#files[@]} -eq 0 ] && { echo "Folder kosong."; exit 1; }

            if [ "$type" = "foto" ]; then
                choice=$(for f in "${files[@]}"; do
                    echo -en "$(basename "${f%.*}")\0icon\x1f$f\x00info\x1f$f\n"
                done | rofi_cmd)
                [ -z "$choice" ] && exit 0
                path="${files[$choice]}"
            else
                index_file="$HOME/.cache/last_index"
                transitions=("grow" "outer" "wipe" "center" "wipe")
                tcount=${#transitions[@]}
                fcount=${#files[@]}
                if [ -f "$index_file" ]; then
                    read t_idx f_idx < "$index_file"
                else
                    t_idx=0; f_idx=0
                fi
                path="${files[$f_idx]}"
                transition="${transitions[$t_idx]}"
                t_idx=$(( (t_idx + 1) % tcount ))
                f_idx=$(( (f_idx + 1) % fcount ))
                echo "$t_idx $f_idx" > "$index_file"
            fi
            prepare_env
            swww img "$path" --transition-type any --transition-duration 2
            wal -i "$path"
            update_hyprlock "$path"
            update_mako
            ;;
        video)
            rofi_check
            dir="$HOME/Videos/Vid_wall"
            thumb="/tmp/video-thumbs"; mkdir -p "$thumb"
            choice=$(for f in "$dir"/*; do
                t="$thumb/$(basename "$f").png"
                [ ! -f "$t" ] && ffmpeg -y -i "$f" -ss 00:00:01 -vframes 1 "$t" >/dev/null 2>&1
                echo -en "$(basename "${f%.*}")\0icon\x1f$t\x00info\x1f$f\n"
            done | rofi_cmd)
            [ -z "$choice" ] && exit 0
            files=("$dir"/*)
            path="${files[$choice]}"
            mode=$(printf " With audio\n No audio" | rofi -dmenu -p " Mode" -theme "$thm2")
            mpvpaper_check
            case "$mode" in
                " With audio") mpvpaper -o "--loop --volume=150" "*" "$path" & ;;
                " No audio") mpvpaper -o "--loop --no-audio" "*" "$path" & ;;
            esac
            ;;
        daemon)
            while true; do
                wallpaper_manager next "$interval"
                sleep "${interval:-300}"
            done
            ;;
    esac
}

# Main
case "$1" in
    foto|video|next|daemon) wallpaper_manager "$1" "$2" ;;
    *) echo "Usage: $0 {foto|video|next|daemon [interval_seconds]}" ;;
esac

#!/bin/bash


if pidof rofi > /dev/null; then
    pkill rofi
fi

theme="$HOME/.config/rofi/themes/screenshoot.rasi"
rc="$HOME/.config/hypr/scripts/record.sh"
pid="/tmp/toggle_recording.pid"

if [ -f "$pid" ]; then
    record_status="RECORDING ■"   # pakai simbol kotak buat stop
else
    record_status="RECORDING ▶"  # pakai simbol play buat start
fi

options="FULL\nAREA\nWINDOW\nCLIPBOARD\n$record_status"
choice=$(echo -e "$options" | rofi -dmenu -p "    SCREENSHOOT/RECORD" -theme "$theme")

full_screenshot() {
    dir="$HOME/Pictures/Screenshot/"
    mkdir -p "$dir"
    FILE="${dir}Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"
    grimblast --wait 0.2  copysave screen "$FILE"
    notify-send "Screenshot screen" "$(basename "$FILE")" -i "$FILE" -t 3000
}

area_screenshot() {
    dir="$HOME/Pictures/Screencut/"
    mkdir -p "$dir"
    FILE="${dir}Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"
    grimblast --wait 0.2  copysave area "$FILE"
    notify-send "Screenshot area" "$(basename "$FILE")" -i "$FILE" -t 3000
}

copy_clipboard() {
    FILE="/tmp/copy.png"
    grimblast --wait 0.2 copysave screen "$FILE"
    [ -f "$FILE" ] && notify-send "Screenshot Copied!" -i "$FILE" -t 3000
    rm -f "$FILE"
}

windowactive() {
    dir="$HOME/Pictures/Screenshot/"
    mkdir -p "$dir"
    FILE="${dir}Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"
    grimblast --wait 0.2 copysave active "$FILE"
    notify-send "Screenshot windowactive" "$(basename "$FILE")" -i "$FILE" -t 3000
}

case "$choice" in
    "FULL")
     full_screenshot
      ;;
    "AREA")
     area_screenshot
      ;;
    "WINDOW")
     windowactive
      ;;
    "CLIPBOARD") 
    copy_clipboard
     ;;
    *RECORDING*)
     $rc 
     ;;
esac 
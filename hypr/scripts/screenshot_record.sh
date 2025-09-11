#!/usr/bin/env bash

# ███████╗ ██████╗██████╗ ███████╗███████╗███╗   ██╗███████╗██╗  ██╗ ██████╗ ████████╗
# ██╔════╝██╔════╝██╔══██╗██╔════╝██╔════╝████╗  ██║██╔════╝██║  ██║██╔═══██╗╚══██╔══╝
# ███████╗██║     ██████╔╝█████╗  █████╗  ██╔██╗ ██║███████╗███████║██║   ██║   ██║   
# ╚════██║██║     ██╔══██╗██╔══╝  ██╔══╝  ██║╚██╗██║╚════██║██╔══██║██║   ██║   ██║   
# ███████║╚██████╗██║  ██║███████╗███████╗██║ ╚████║███████║██║  ██║╚██████╔╝   ██║   
# ╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝    ╚═╝   
#  ██████╗ ███████╗ ██████╗ ██████╗ ██████╗ ██████╗ 
# ██╔══██╗██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔══██╗
# ██████╔╝█████╗  ██║     ██║   ██║██████╔╝██║  ██║
# ██╔══██╗██╔══╝  ██║     ██║   ██║██╔══██╗██║  ██║
# ██║  ██║███████╗╚██████╗╚██████╔╝██║  ██║██████╔╝
# ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝ 
                                                                                                                                    

if pidof rofi > /dev/null; then
    pkill rofi
fi

<<<<<<< HEAD
theme="$HOME/.config/rofi/themes/power_menu.rasi"
=======
theme="$HOME/.config/rofi/themes/screenshot.rasi"
>>>>>>> 8f4e832f277cab6e74f992d06fa86d33542e4e82
pid="/tmp/toggle_recording.pid"

if [ -f "$pid" ]; then
    record_status="STOP RECORDING ■"   # pakai simbol kotak buat stop
else
    record_status="START RECORDING ▶"  # pakai simbol play buat start
fi

full_screenshot() {
    dir="$HOME/Pictures/Screenshot/"
    mkdir -p "$dir"
    FILE="${dir}Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"
    grimblast copysave screen "$FILE"
    notify-send "Screenshot screen" "$(basename "$FILE")" -i "$FILE" -t 3000
}

area_screenshot() {
    dir="$HOME/Pictures/Screenshot/Screencut/"
    mkdir -p "$dir"
    FILE="${dir}Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"
    grimblast copysave area "$FILE"
    notify-send "Screenshot area" "$(basename "$FILE")" -i "$FILE" -t 3000
}

copy_clipboard() {
    FILE="/tmp/copy.png"
    grimblast copysave screen "$FILE"
    [ -f "$FILE" ] && notify-send "Screenshot Copied!" -i "$FILE" -t 3000
    rm -f "$FILE"
}

windowactive() {
    dir="$HOME/Pictures/Screenshot/Windowactive/"
    mkdir -p "$dir"
    FILE="${dir}Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"
    grimblast copysave active "$FILE"
    notify-send "Screenshot windowactive" "$(basename "$FILE")" -i "$FILE" -t 3000
}

record() {
    # 📁 Folder hasil rekaman
    SAVE_DIR="$HOME/Videos/Recordings"
    mkdir -p "$SAVE_DIR"

    f="/var/lib/AccountsService/icons/$USER"

    # 📄 File penanda recording aktif
    PID_FILE="/tmp/toggle_recording.pid"

    if [ ! -f "$PID_FILE" ]; then
        # Belum rekam → MULAI REKAMAN

        # Nama file unik
        FILENAME="Recording_$(date +'%Y-%m-%d_%H-%M-%S')"
        VIDEO_FILE="/tmp/recording_video_${FILENAME}.mp4"
        AUDIO_FILE="/tmp/recording_audio_${FILENAME}.wav"
        FINAL_FILE="$SAVE_DIR/${FILENAME}.mp4"

        # 🔊 Audio dari device/output (bukan mic)
        # AUDIO_SOURCE="alsa_output.pci-0000_00_1b.0.analog-stereo.monitor"
        AUDIO_SOURCE=$(pactl list short sources | grep -m1 "monitor" | awk '{print $2}')

        #  Simpan path file sementara (biar bisa diakses pas stop)
        echo "$VIDEO_FILE;$AUDIO_FILE;$FINAL_FILE" > /tmp/toggle_recording_files

        # ▶ Rekam audio di background
        parec -d "$AUDIO_SOURCE" --format=s16le --rate=48000 --channels=2 > "$AUDIO_FILE" &
        AUDIO_PID=$!

        #  Rekam video di background
        wf-recorder --no-damage -r 60 -f "$VIDEO_FILE" &
        VIDEO_PID=$!

        # Simpan PID kedua proses
        echo "$VIDEO_PID:$AUDIO_PID" > "$PID_FILE"

        notify-send -t 2000 -i "$f" "⏺ Recording started" "Press the shortcut again to stop"

    else
        # Sedang rekam → HENTIKAN + GABUNG

        # Ambil PID
        IFS=":" read VIDEO_PID AUDIO_PID < "$PID_FILE"
        IFS=";" read VIDEO_FILE AUDIO_FILE FINAL_FILE < /tmp/toggle_recording_files

        # Kill secara elegan
        kill "$VIDEO_PID" 2>/dev/null
        kill "$AUDIO_PID" 2>/dev/null

        # Tunggu proses selesai
        wait "$VIDEO_PID"
        wait "$AUDIO_PID"

        # Gabungin
        notify-send -i "$f" " Merging audio + video..."
        ffmpeg -y -i "$VIDEO_FILE" -f s16le -ar 48000 -ac 2 -i "$AUDIO_FILE" \
               -c:v copy -c:a aac "$FINAL_FILE"

        # Bersih-bersih
        rm "$VIDEO_FILE" "$AUDIO_FILE" "$PID_FILE" /tmp/toggle_recording_files

        notify-send -i "$f" "✅ Recording finished" "$FINAL_FILE"
        echo "✅ Recording finished: $FINAL_FILE"
    fi
}

if [ -n "$1" ]; then

    # kalau ada argumen → langsung eksekusi tanpa rofi
    case "${1^^}" in
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
         record 
         ;;
    esac

else
    # kalau nggak ada argumen → buka rofi
    options="FULL\nAREA\nWINDOW\nCLIPBOARD\n$record_status"
    choice=$(echo -e "$options" | rofi -dmenu -p "    SCREENSHOOT/RECORD" -theme "$theme")

        [ -z "$choice" ] && exit 0

    case "$choice" in
        "FULL")
         sleep 0.2
         full_screenshot
          ;;
        "AREA")
         sleep 0.2
         area_screenshot
          ;;
        "WINDOW")
         sleep 0.2
         windowactive
          ;;
        "CLIPBOARD")
         sleep 0.2 
         copy_clipboard
         ;;
        *RECORDING*)
         record 
         ;;
    esac 

fi

#!/usr/bin/env bash

# ██╗  ██╗██╗   ██╗██████╗ ██████╗ ██╗      ██████╗  ██████╗██╗  ██╗
# ██║  ██║╚██╗ ██╔╝██╔══██╗██╔══██╗██║     ██╔═══██╗██╔════╝██║ ██╔╝
# ███████║ ╚████╔╝ ██████╔╝██████╔╝██║     ██║   ██║██║     █████╔╝ 
# ██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══██╗██║     ██║   ██║██║     ██╔═██╗ 
# ██║  ██║   ██║   ██║     ██║  ██║███████╗╚██████╔╝╚██████╗██║  ██╗
# ╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝

f="/var/lib/AccountsService/icons/$USER"

anitext() {
    s=("Howdy my Sigma!"
    "I USE ARCH BTW" 
    "Consider taking a bath?" 
    "Arch is so GOATed UwU" 
    "VScode > Neovim FrFr"
    "Please don't touch my PC!"
    "sudo pacman -S girlfriend --noconfirm"
    "Error: Girlfriend not found."
    "I love you, but I need to go to sleep now."
    "I wish I had an angel for one moment of love."
    "Life is short, update your software."
    )

    scripttext="/tmp/scripttext"
    ptx=0

    while [ $ptx -lt ${#s[@]} ]; do
        ans=""
        # Update teks tiap 2 huruf sekaligus supaya ga skip render
        step=2
        for ((i = 0; i < ${#s[ptx]}; i+=step)); do
            ans="${s[ptx]:0:i+step}"
            echo "$ans"
            echo "$ans" > "$scripttext"
            sleep 0.3  # bisa diubah 0.2 atau 0.25 untuk lebih cepat
        done
        sleep 7
        # Hapus teks juga pakai step
        for ((i=${#s[ptx]}; i>=0; i-=step)); do
            ans="${s[ptx]:0:i}"
            echo "$ans"
            echo "$ans" > "$scripttext"
            sleep 0.2
        done
        ptx=$((ptx + 1))
        if [ $ptx -eq ${#s[@]} ]; then
            ptx=0
        fi
    done
}

weather() {
    weathertext="/tmp/weathertext"
    while true; do
        city=$(curl -s https://ipinfo.io/json | grep -o '"city": *"[^"]*"' | cut -d '"' -f 4 | sed 's/ /%20/g')
        weather=$(curl -s "https://wttr.in/$city?format=%25l%3A%20%25C%2C%20%25t")
        weather_len=${#weather}
        output=""
        i=0
        while [ $i -lt $weather_len ]; do
            if [ $i -eq 30 ]; then
                output="$output..."
                break
            fi
            char=$(printf "%s" "$weather" | cut -c $((i + 1)))
            output="$output$char"
            i=$((i + 1))
        done
        if [ "$output" != "" ]; then
            echo "$output" > "$weathertext"
        fi
        sleep 60
    done

}

# jalankan di background
# anitext &
# PID_ANITEXT=$!
# weather &
# PID_WEATHER=$!

# simpan PID untuk safety (opsional)
# echo "$PID_ANITEXT $PID_WEATHER" > /tmp/hypr_if_pids

# jalankan hyprlock
pidof hyprlock >/dev/null || hyprlock

# setelah hyprlock keluar, otomatis kill hiburan
# kill $PID_ANITEXT $PID_WEATHER 2>/dev/null
# rm -f /tmp/hypr_if_pids 
# rm -f /tmp/scripttext

notify-send -i "$f" "Welcome back" "$USER"

#!/usr/bin/env bash

# ██╗  ██╗██╗   ██╗██████╗ ██████╗ ██╗      ██████╗  ██████╗██╗  ██╗
# ██║  ██║╚██╗ ██╔╝██╔══██╗██╔══██╗██║     ██╔═══██╗██╔════╝██║ ██╔╝
# ███████║ ╚████╔╝ ██████╔╝██████╔╝██║     ██║   ██║██║     █████╔╝ 
# ██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══██╗██║     ██║   ██║██║     ██╔═██╗ 
# ██║  ██║   ██║   ██║     ██║  ██║███████╗╚██████╔╝╚██████╗██║  ██╗
# ╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝

f="/var/lib/AccountsService/icons/$USER"

anitext() {
# Source: Mon4sm
# URL: https://github.com/Mon4sm/monasm-dots/blob/main/.config/hypr/scripts/text_animation/anitext.sh
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

# jalankan di background
anitext &
PID_ANITEXT=$!

# simpan PID untuk safety (opsional)
echo "$PID_ANITEXT" > /tmp/hypr_if_pids

# jalankan hyprlock
pidof hyprlock >/dev/null || hyprlock

# setelah hyprlock keluar, otomatis kill hiburan
kill $PID_ANITEXT $PID_WEATHER 2>/dev/null
rm -f /tmp/hypr_if_pids /tmp/scripttext

notify-send -i "$f" "Welcome back" "$USER"

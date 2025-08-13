#!/bin/bash

# cek proses waybar
pid=$(pgrep -x waybar)

if [ -z "$pid" ]; then
    # kalau ga ada proses waybar, berarti waybar off, kita start
    echo "Waybar gak jalan, start waybar..."
    waybar & disown
else
    # kalau ada proses waybar, berarti waybar on, kita kill (hide)
    echo "Waybar jalan, kill waybar (hide)..."
    kill "$pid"
fi

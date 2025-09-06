#!/usr/bin/env bash

# Ambil warna accent dari pywal
BORDER=$(sed -n '12p' ~/.cache/wal/colors)

# Ganti border-color global (sebelum [app-name=...])
sed -i "0,/^\[app-name=/ s/^border-color=.*/border-color=$BORDER/" ~/.config/mako/config

# Reload mako supaya langsung berubah
pkill -USR1 mako

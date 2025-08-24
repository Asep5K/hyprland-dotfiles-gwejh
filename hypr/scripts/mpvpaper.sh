#!/bin/bash

export WAYLAND_DISPLAY=wayland-1
export XDG_RUNTIME_DIR=/run/user/1000

if pgrep -x mpvpaper >/dev/null; then
    killall mpvpaper
else
    setsid -f mpvpaper -o "--loop --no-audio" "*" /home/histed/Videos/random/bagas_bagas.mp4
fi

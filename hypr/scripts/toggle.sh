#!/usr/bin/env bash

# ████████╗ ██████╗  ██████╗  ██████╗ ██╗     ███████╗
# ╚══██╔══╝██╔═══██╗██╔════╝ ██╔════╝ ██║     ██╔════╝
#    ██║   ██║   ██║██║  ███╗██║  ███╗██║     █████╗  
#    ██║   ██║   ██║██║   ██║██║   ██║██║     ██╔══╝  
#    ██║   ╚██████╔╝╚██████╔╝╚██████╔╝███████╗███████╗
#    ╚═╝    ╚═════╝  ╚═════╝  ╚═════╝ ╚══════╝╚══════╝

f="/var/lib/AccountsService/icons/$USER"

toggle() {
    case "$1" in
        Hypridle)
            if pgrep -x hypridle > /dev/null; then
                pkill -x  hypridle
                notify-send -i "$f" -a "hyprstop" "Hypridle stopped"
            else
                hypridle dev/null 2>&1 &
                notify-send -i "$f" -a "hyprstart" "Hypridle started"
            fi
            ;;
        Clock)
            exec notify-send -t 5000 -i "$f"  "DATE & TIME" \
            "$(LC_TIME=en_US.UTF-8 date '+%A,%B %d,%Y\n%H:%M:%S')" 
            ;;
        Waybar)
            if pgrep -x waybar > /dev/null; then
                pkill -x  waybar 
            else
                waybar > /dev/null 2>&1 &
            fi
            ;;
     esac
}

case "$1" in 
    Hypridle|Clock|Waybar) toggle "$1" ;;
esac
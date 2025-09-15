#!/usr/bin/env bash

# ██████╗  ██████╗ ██╗    ██╗███████╗██████╗     ███╗   ███╗███████╗███╗   ██╗██╗   ██╗
# ██╔══██╗██╔═══██╗██║    ██║██╔════╝██╔══██╗    ████╗ ████║██╔════╝████╗  ██║██║   ██║
# ██████╔╝██║   ██║██║ █╗ ██║█████╗  ██████╔╝    ██╔████╔██║█████╗  ██╔██╗ ██║██║   ██║
# ██╔═══╝ ██║   ██║██║███╗██║██╔══╝  ██╔══██╗    ██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║   ██║
# ██║     ╚██████╔╝╚███╔███╔╝███████╗██║  ██║    ██║ ╚═╝ ██║███████╗██║ ╚████║╚██████╔╝
# ╚═╝      ╚═════╝  ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝    ╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝ 

if pidof rofi > /dev/null; then
    pkill rofi
fi

theme="$HOME/.config/rofi/themes/power_menu.rasi"
f="/var/lib/AccountsService/icons/$USER"

daemon=( "wallpaper_select.sh" "mako" "swww-daemon" "wl-paste" )
apps=( "code-oss" "brave" "foot" "Telegram" "spotify" "electron" "yazi" )

kill_daemon() {
  for d in "${daemon[@]}"; do
    if pgrep -f "$d" > /dev/null; then
      pkill -f "$d"
    fi
  done
}

kill_apps() {
  for app in "${apps[@]}"; do
    if pgrep -x "$app" > /dev/null; then
      pkill -x "$app"
    fi
  done
}

closewindow() {
# Source: Suchith Sridhar’s dotfiles
# URL: https://github.com/SuchithSridhar/nixos-dotfiles/blob/60b591a3f0d93c65ef9d25eb36e3a4f121bb3fb2/scripts/power-controls

    BRAVE=$(hyprctl clients | grep "class: brave-browser" | wc -l)
    CHROMIUM=$(hyprctl clients | grep "class: chromium" | wc -l)
    FIREFOX=$(hyprctl clients | grep "class: firefox" | wc -l)

    if [ "$BRAVE" -gt "1" ]; then
        notify-send -i "$f" "power controls" "Brave multiple windows open"
        exit 1
    elif [ "$CHROMIUM" -gt "1" ]; then
        notify-send -i "$f" "power controls" "Chromium multiple windows open"
        exit 1
    elif [ "$FIREFOX" -gt "1" ]; then
        notify-send -i "$f" "power controls" "Firefox multiple windows open"
        exit 1
    fi

    sleep 3

    # close all client windows
    # required for graceful exit since many apps aren't good SIGNAL citizens
    mkdir -p /tmp/hypr
    HYPRCMDS=$(hyprctl -j clients | jq -j '.[] | "dispatch closewindow address:\(.address); "')
    hyprctl --batch "$HYPRCMDS" >> /tmp/hypr/hyprexitwithgrace.log 2>&1

    notify-send -i "$f" "power controls" "Closing Applications..."

    sleep 2

    COUNT=$(hyprctl clients | grep "class:" | wc -l)
    if [ "$COUNT" -eq "0" ]; then
        notify-send -i "$f" "power controls" "Closed Applications."
        return
    else
        notify-send -i "$f" "power controls" "Some apps didn't close. Not shutting down."
        exit 1
    fi
}

lock() {
  if ! pidof hypridle > /dev/null; then
     hypridle &
  fi
  loginctl lock-session
}

pwf() {
  if confirm "Are you sure you want to shutdown?"; then
    closewindow
   sleep 1
   kill_daemon
   sleep 1
   kill_apps
   sleep 3
    systemctl poweroff
  fi
}

rbt() {
    if confirm "Are you sure you want to reboot?"; then
    closewindow
    sleep 1
    kill_daemon
    sleep 1
    kill_apps
    sleep 3
    systemctl reboot
  fi
}

logout() {
  if confirm "Are you sure you want to logout?"; then
    closewindow
    kill_daemon
    kill_apps
    hyprctl dispatch exit
  fi
}

confirm() {
  local question="$1"
  local answer=$(echo -e " Yes\n No" | rofi -dmenu -p "$question" -theme  "$theme")
  if [[ "$answer" == " Yes" ]]; then
    return 0
  else
    return 1
  fi
}

options=" Shutdown\n Reboot\n Lock\n Sleep\n Logout"

action=$(echo -e "$options" | rofi -dmenu -p "               POWER MENU" -theme "$theme")

case "$action" in
  " Shutdown")
    pwf
    ;;
  " Reboot")
    rbt
    ;;
  " Lock")
    lock
    ;;
  " Sleep")
    lock
    systemctl suspend
    ;;
  " Logout")
    logout
    ;;
  *)
    if [[ -n "$action" ]]; then
      notify-send -i "$f" "Running command" "$action"
      bash -c "$action"
    fi
    ;;
esac

#!/bin/bash

if pidof rofi > /dev/null; then
    pkill rofi
fi

theme="$HOME/.config/rofi/themes/power_menu.rasi"

# Gunakan SIGTERM (default) daripada -9
pk=(pkill -x)

pkl() {
  # Kill apps yang aman dulu
  "${pk[@]}" anitext.sh
  "${pk[@]}" weather.sh
  "${pk[@]}" randomwallpaper.sh
  "${pk[@]}" getvol.sh
  "${pk[@]}" yazi.sh
  "${pk[@]}" eww
  "${pk[@]}" code-oss
  "${pk[@]}" kitty
  "${pk[@]}" mako

  # Brave & Spotify pakai SIGTERM (tidak paksa) biar cleanup lock
  "${pk[@]}" brave
  "${pk[@]}" spotify
  "${pk[@]}" Telegram
}

pwf() {
  notify-send -t 2000 "Shutdown in 5 seconds"
  sleep 2
  pkl
  sleep 3
  systemctl poweroff
}

rbt() {
  notify-send -t 2000 "Rebooting in 5 seconds"
  sleep 2
  pkl
  sleep 3
  systemctl reboot
}

confirm() {
  local question="$1"
  local answer=$(echo -e "Yes\nNo" | rofi -dmenu -p "$question" -theme  "$theme")
  if [[ "$answer" == "Yes" ]]; then
    return 0
  else
    return 1
  fi
}

options="⏻ Shutdown\n🔁 Reboot\n🔒 Lockscreen\n💤 Sleep\n🚪 Logout"

action=$(echo -e "$options" | rofi -dmenu -p "               POWER MENU" -theme "$theme")

case "$action" in
  "⏻ Shutdown")
    if confirm "Are you sure you want to shutdown?"; then
      pwf
    fi
    ;;
  "🔁 Reboot")
    if confirm "Are you sure you want to reboot?"; then
      rbt
    fi
    ;;
  "🔒 Lockscreen")
    "$HOME/.config/hypr/scripts/hyprlock.sh"
    ;;
  "💤 Sleep")
    systemctl sleep
    ;;
  "🚪 Logout")
    if confirm "Are you sure you want to logout?"; then
      pkl
      hyprctl dispatch exit
    fi
    ;;
  *)
    if [[ -n "$action" ]]; then
      notify-send "Running command" "$action"
      bash -c "$action"
    fi
    ;;
esac

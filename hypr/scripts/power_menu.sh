#!/bin/bash

confirm() {
  local question="$1"
  local answer=$(echo -e "Yes\nNo" | rofi -dmenu -p "$question" -theme-str '
  window {
    width: 25%;
    padding: 0.09;
    height: 30%;
  }
  listview {
    lines: 2;
  }
  element {
    padding: 20 20;
  }
  element selected {
    background-color: #89b4fa;
    text-color: #1e1e2e;
  }
  ')
  if [[ "$answer" == "Yes" ]]; then
    return 0
  else
    return 1
  fi
}

options="⏻ Shutdown\n🔁 Reboot\n🔒 Lockscreen\n💤 Sleep\n❌ Cancel"

action=$(echo -e "$options" | rofi -dmenu -p "Power (or type command):" -theme-str '
window {
  width: 30%;
  padding: 5;
  height: 40%;
}
listview {
  lines: 5;
}
element {
  padding: 10 26;
}
element selected {
  background-color: #89b4fa;
  text-color: #1e1e2e;
}
')

case "$action" in
  "⏻ Shutdown")
    if confirm "Are you sure you want to shutdown?"; then
      notify-send -t 3000 "Shutdown in 5 seconds"
      sleep 5
      poweroff
    fi
    ;;
  "🔁 Reboot")
    if confirm "Are you sure you want to reboot?"; then
      notify-send -t 3000 "Rebooting in 5 seconds"
      sleep 5
      reboot
    fi
    ;;
  "🔒 Lockscreen")
    hyprlock
    ;;
  "💤 Sleep")
    systemctl sleep
    ;;
  "❌ Cancel"|"" )
    notify-send "Cancelled" "No action taken."
    ;;
  *)
    # Jalankan perintah custom langsung tanpa konfirmasi
    notify-send "Running command" "$action"
    bash -c "$action"
    ;;
esac

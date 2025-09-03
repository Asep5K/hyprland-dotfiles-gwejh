#!/bin/bash

OPTIONS="Minecraft Java\nMinecraft Bedrock\nOption 3\n❌ Keluar"

THEME="$HOME/.config/rofi/themes/gamelauncher_5.rasi"

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -p  "Pilih opsi:" -theme "$THEME")

case "$CHOICE" in
  "Minecraft Java")
    sklauncher
    ;;
  "Minecraft Bedrock")
    mcpelauncher-ui-qt
    ;;
  "Option 3")
    notify-send "Kamu pilih Option 3"
    ;;
  "❌ Keluar")
    exit 0
    ;;
  *)
    notify-send "Pilihan tidak valid"
    ;;
esac

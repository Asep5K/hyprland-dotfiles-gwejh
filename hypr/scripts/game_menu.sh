#!/bin/bash

OPTIONS="Minecraft Java\nMinecraft Bedrock\nOption 3\nKeluar"

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -p "Pilih opsi:" -theme-str '
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

case "$CHOICE" in
  "Minecraft Java")
    echo "Launching Minecraft Java..."
    java -jar ~/Downloads/TLauncher.jar
    ;;
  "Minceraft Bedrock")
    echo "Launching Mineraft Bedrock..."
    rofi -show drun
    ;;
  "Option 3")
    echo "Kamu pilih Option 3"
    ;;
  "Keluar")
    echo "Bye!"
    exit 0
    ;;
  *)
    echo "Pilihan tidak valid"
    ;;
esac

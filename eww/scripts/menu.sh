#!/bin/bash

names=(
  "Brave Browser"
  "Btop"
  "Discord"
  "Gimp"
  # "Kdenlive"
  "Telegram"
  "Neovim"
  "Vscode"
  "yazi"
)

execs=(
  "brave"
  "btop"
  "/usr/bin/discord"
  "gimp"
  # "kdenlive
  "Telegram"
  "nvim"
  "code"
  "yazi"
)

icons=(
  "/usr/share/icons/hicolor/128x128/apps/brave-desktop.png"
  "/usr/share/icons/hicolor/scalable/apps/btop.svg"
  "/usr/share/icons/hicolor/128x128/apps/discord.png"
  "/usr/share/icons/hicolor/128x128/apps/gimp.png"
  # "/usr/share/icons/hicolor/128x128/apps/kdenlive.png"
  "/usr/share/icons/hicolor/128x128/apps/org.telegram.desktop.png"
  "/usr/share/icons/hicolor/128x128/apps/nvim.png"
  "/usr/share/icons/hicolor/128x128/apps/vscode.png"
  "/usr/share/icons/hicolor/128x128/apps/yazi.png"
)

terminal=(
  false
  true
  false
  false
  false
  true
  false
  false
)

json="["

for i in "${!names[@]}"; do
  [[ $i -ne 0 ]] && json+=","
  json+="{\"name\":\"${names[$i]}\",\"exec\":\"${execs[$i]}\",\"icon\":\"${icons[$i]}\",\"terminal\":\"${terminal[$i]}\"}"
done

json+="]"
echo "$json"

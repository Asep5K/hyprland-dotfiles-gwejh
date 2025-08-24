#!/bin/bash

names=(
  "Brave Browser"
  "Btop"
  "Discord"
  "Minecraft Launcher"
  "Neovim"
  "OBS Studio"
  "Spotify"
  "VScode"
)

execs=(
  "brave"
  "btop"
  "/usr/bin/discord"
  "java -jar $HOME/Downloads/TLauncher.jar"
  "nvim"
  "obs"
  "LD_PRELOAD=/usr/lib/spotify-adblock.so spotify"
  "code"
)

icons=(
  "/usr/share/icons/hicolor/128x128/apps/brave-desktop.png"
  "/usr/share/icons/hicolor/scalable/apps/btop.svg"
  "/usr/share/icons/hicolor/128x128/apps/discord.png"
  "/usr/share/icons/Dracula/scalable/apps/minecraft-launcher.svg"
  "/usr/share/icons/hicolor/128x128/apps/nvim.png"
  "/usr/share/icons/hicolor/256x256/apps/com.obsproject.Studio.png"
  "/usr/share/icons/hicolor/128x128/apps/spotify.png"
  "/usr/share/icons/hicolor/128x128/apps/vscode.png"
)

terminal=(
  false
  true
  false
  false
  true
  false
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

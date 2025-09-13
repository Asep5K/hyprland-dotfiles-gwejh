#!/usr/bin/env bash
set -e

CONFIG_FOLDERS=(hypr waybar rofi eww mako yazi cava)
BACKUP_DIR="$HOME/config_backup_$(date +%Y%m%d)"
TARGET_DIR="$HOME/.config"
PKG_FILE="./packages.txt"
MISSING=()

# 1️⃣ Cek paket
while read -r pkg; do
    [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue
    if pacman -Qi "$pkg" &>/dev/null || yay -Qi "$pkg" &>/dev/null; then
        echo "[INSTALLED] $pkg"
    else
        echo "[MISSING]  $pkg"
        MISSING+=("$pkg")
    fi
done < "$PKG_FILE"

if [ ${#MISSING[@]} -gt 0 ]; then
    echo
    echo ">>> Installing missing packages..."
    yay -S --needed "${MISSING[@]}"
else
    echo
    echo "All packages are already installed!"
fi

# 2️⃣ Backup config lama dari ~/.config
mkdir -p "$BACKUP_DIR"
for folder in "${CONFIG_FOLDERS[@]}"; do
    if [[ -d "$TARGET_DIR/$folder" ]]; then
        echo "Backing up $folder from ~/.config to $BACKUP_DIR/"
        cp -r "$TARGET_DIR/$folder" "$BACKUP_DIR/"
    fi
done

# 3️⃣ Copy config baru dari repo ke ~/.config
for folder in "${CONFIG_FOLDERS[@]}"; do
    if [[ -d "$folder" ]]; then
        echo "Installing new $folder..."
        cp -r "$folder" "$TARGET_DIR/"
    fi
done

# 4️⃣ Chmod executable script
if [[ -d "$TARGET_DIR/eww/scripts" ]]; then
    chmod +x "$TARGET_DIR/eww/scripts/"*.sh
fi
if [[ -d "$TARGET_DIR/hypr/scripts" ]]; then
    chmod +x "$TARGET_DIR/hypr/scripts/"*.sh
fi

echo "Backup done at $BACKUP_DIR"
echo "Configs updated!"

# My Hyprland Setup 🖤

Personal configs, scripts & packages to try my desktop.  
Mostly tinkering for fun, not a “ricing masterpiece.”  
Use it if you like, edit it if you see something missing.  
Happy Hyprlanding! 🚀


## 📸 Screenshots

![](./preview/Preview.png)  
![](./preview/Wallpaper_selector.png)  
![](./preview/Video_wallpaper_selector.png)  
![](./preview/Keybind_list.png)  
![](./preview/Screenshot_menu.png)  
![](./preview/Power_menu.png)  
![](./preview/Wifi_menu.png) 
![](./preview/Hyprlock.png)   

---

## 🛠️ Install

⚠️ Currently the installer script only supports Arch Linux (and AUR helpers like yay/paru).  
Other distros are not supported out of the box.
```bash
git clone https://github.com/Asep5K/iuno-dots.git
cd iuno-dots
chmod +x install.sh
./install.sh
```
> ℹ️ Note: The installer will automatically back up your existing configs before applying mine.  

## 📑 Sources / Credits

- **rofi-wifi-menu.sh** → [ericmurphyxyz](https://github.com/ericmurphyxyz/rofi-wifi-menu/tree/master)  
- **hyprlock.conf, hypridle.conf, hypridle.sh** → [Mon4sm](https://github.com/Mon4sm/monasm-dots)  
- **hyprlock.conf, emoji_launcher.sh, wallpaper_select.sh, clipboard_launcher.sh, key_hints.sh, waybar** → [ViegPhunt](https://github.com/ViegPhunt/Dotfiles)  
- **rofi themes** → [newmanls](https://github.com/newmanls/rofi-themes-collection)  

---

## 📦 Requirements

### Core (Hyprland ecosystem)
- [**Hyprland**](https://github.com/hyprwm/Hyprland) → Wayland compositor
- [**hyprlock**](https://github.com/hyprwm/hyprlock) → lockscreen
- [**hypridle**](https://github.com/hyprwm/hypridle) → idle management (auto lock/suspend)

### 🖥️ Terminal
- [**foot**](https://github.com/r-c-f/foot) → lightweight terminal emulator

### UI & Widgets
- [**rofi-wayland**](https://github.com/in0ni/rofi-wayland) → app launcher
- [**rofi-emoji**](https://github.com/Mange/rofi-emoji) → emoji launcher
- [**Waybar**](https://github.com/Alexays/Waybar) → status bar
- [**mako**](https://github.com/emersion/mako) → notification daemon

### 🎨 Wallpaper & Theming
- [**swww**](https://github.com/LGFae/swww) → wallpaper daemon
- [**python-pywal**](https://github.com/dylanaraps/pywal) → generate colorscheme from wallpaper
- [**mpvpaper**](https://github.com/GhostNaN/mpvpaper) → video wallpaper

### CLI Utilities
- [**btop**](https://github.com/aristocratos/btop) → system monitor  
- [**yazi**](https://github.com/sxyazi/yazi) → terminal file manager  
- [**wl-clipboard**](https://github.com/bugaevc/wl-clipboard) → clipboard utilities  
- [**yad**](https://github.com/v1cont/yad) → simple GUI dialogs  
- [**peaclock**](https://github.com/octobanana/peaclock) → customizable clock  
- [**cava**](https://github.com/karlstav/cava) → audio visualizer  

### 📸 Screenshot
- [**grim**](https://github.com/emersion/grim) → screenshot utility  
- [**grimblast**](https://github.com/hyprwm/contrib/tree/main/grimblast) → wrapper for easier screenshots  

### 🎥 Recording
- [**wf-recorder**](https://github.com/ammen99/wf-recorder) → screen recording utility

---
# Hyprland Dotfiles

My personal configuration for [Hyprland](https://github.com/hyprwm/Hyprland), focused on ricing, productivity, and minimalism.  
This repo contains configuration files, scripts, and the required packages to replicate my setup.

## 📸 Screenshots

![](./preview/Preview.png)  
![](./preview/Wallpaper_selector.png)  
![](./preview/Video_wallpaper_selector.png)  
![](./preview/Keybind_list.png)  
![](./preview/Screenshot_menu.png)  
![](./preview/Power_menu.png)  
![](./preview/Wifi_menu.png)  

---

## 📑 Sources / Credits

- **rofi-wifi-menu.sh** → [adi1090x/rofi](https://github.com/adi1090x/rofi)  
- **eww bar, hyprlock.conf, hypridle.conf** → [Mon4sm/monasm-dots](https://github.com/Mon4sm/monasm-dots)  
- **emoji_launcher.sh, wallpaper_select.sh, clipboard_launcher.sh, key_hints.sh, waybar** → [ViegPhunt/Dotfiles](https://github.com/ViegPhunt/Dotfiles)  
- **rofi themes** → [newmanls/rofi-themes-collection](https://github.com/newmanls/rofi-themes-collection)  

---

## 📦 Requirements

### Core (Hyprland ecosystem)
- **hyprland** → Wayland compositor
- **hyprlock** → lockscreen
- **hypridle** → idle management (auto lock/suspend)

### Terminal
- **kitty** → GPU-based terminal emulator
- **foot** → lightweight terminal emulator

### UI & Widgets
- **rofi-wayland** → app launcher
- **waybar** → status bar
- **eww** → widgets
- **conky-cairo-wayland** → system monitor widget
- **mako** → notification daemon

### Wallpaper & Theming
- **swww** → wallpaper daemon
- **python-pywal** → generate colorscheme from wallpaper

### CLI Utilities
- **btop** → system monitor  
- **yazi** → terminal file manager  
- **wl-copy / wl-paste** → clipboard utilities  
- **yad** → simple GUI dialogs  
- **peaclock** → customizable clock  
- **cava** → audio visualizer  

### Screenshot
- **grim** → screenshot utility  
- **grimblast** → wrapper for easier screenshots  

---

## 📂 Repository Structure

.
├── hypr/           # Hyprland configs (hyprland.conf, hyprlock.conf, hypridle.conf, etc.)
├── waybar/         # Waybar configs and styles
├── rofi/           # Rofi themes and scripts (launchers, menus, etc.)
├── eww/            # Eww bar and widgets
├── mako/           # Notification daemon configs
├── yazi/           # Yazi file manager config
├── cava/           # Cava audio visualizer config
├── preview/        # Screenshots / previews
├── packages.txt    # List of required packages
└── README.md       # Project documentation
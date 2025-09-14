#!/usr/bin/env bash

#  █████╗ ██████╗ ██████╗ ██╗     ██╗ ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
# ██╔══██╗██╔══██╗██╔══██╗██║     ██║██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
# ███████║██████╔╝██████╔╝██║     ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║███████╗
# ██╔══██║██╔═══╝ ██╔═══╝ ██║     ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║
# ██║  ██║██║     ██║     ███████╗██║╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║███████║
# ╚═╝  ╚═╝╚═╝     ╚═╝     ╚══════╝╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝

app=$1
term="foot -e"
thm="$HOME/.config/rofi/themes/wall.rasi"
gm="sklauncher
mcpelauncher-ui-qt"


rofi_check() {
    if pidof rofi > /dev/null; then
        pkill rofi
    fi
}

apps() {
    case "$app" in
        Menu)
        rofi_check
        rofi -show drun -show-icons -icon-theme Papirus
         ;;
        Spotify)
        exec env LD_PRELOAD=/usr/lib/spotify-adblock.so spotify --uri=%U > /dev/null 2>&1
        ;;
        Brave)
        exec brave > /dev/null 2>&1
        ;;
        Code)
        code-oss > /dev/null 2>&1
        ;;
        Yazi)
        export EDITOR=nvim
        export VISUAL=nvim
        export LIBVA_DRIVER_NAME="i965"
        exec $term yazi > /dev/null 2>&1
        ;;
        Cmus)
        exec $term cmus > /dev/null 2>&1
        ;;
        Cava)
        exec $term cava > /dev/null 2>&1
        ;;
        Btop)
        exec $term btop > /dev/null 2>&1
        ;;
        Kdenlive)
        exec kdenlive > /dev/null 2>&1
        ;;
        Tele)
        exec Telegram > /dev/null 2>&1
        ;;
        Discord)
        exec discord > /dev/null 2>&1
        ;;
        Conky)
        exec conky -c $HOME/.config/conky/Regulus.conf > /dev/null 2>&1 
        ;;
        Foot)
        exec foot > /dev/null 2>&1
        ;;
        Window)
        rofi_check
        exec rofi -show window -show-icons -theme "$thm" > /dev/null 2>&1
        ;;
        Mpv)
        exec mpv --loop=inf --no-audio  $HOME/Videos/random/lupa.mp4
        ;;
        Emoji)
        rofi_check
        rofi -show emoji 
        ;;
        Clipboard)
        rofi_check
        cliphist list | rofi -dmenu -p  "Clipboard" | cliphist decode | wl-copy
        ;;
        Game)
        rofi_check
        chosen=$(echo -e "$gm" | rofi -dmenu -p "Launch App")
        if [ -n "$chosen" ]; then
          $chosen &
        fi
        ;;
    esac 
}
case "$app" in
    Menu|Spotify|Brave|Yazi|Cmus|Cava|Btop|Kdenlive|\
    Tele|Discord|Conky|Window|Foot|Code|Mpv|Emoji|\
    Clipboard|Game) apps "$app" ;;
esac

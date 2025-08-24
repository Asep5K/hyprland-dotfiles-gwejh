#!/bin/bash

s=("Howdy my Sigma!" 
"Consider taking a bath?" 
"Arch is so GOATed UwU" 
"VScode > Neovim FrFr"
"Please don't touch my PC!"
"sudo pacman -S girlfriend -y"
"Error: Girlfriend not found."
"I love you, but I need to go to sleep now."
"I wish I had an angel for one moment of love."
"Life is short, update your software."
)

scripttext=$HOME/.config/hypr/scripts/text_animation/scripttext
ptx=0

while [ $ptx -lt ${#s[@]} ]; do
    ans=""
    for ((i = 0; i < ${#s[ptx]}; i++)); do
        ans+="${s[ptx]:i:1}"
	echo "$ans"
        echo "$ans" > "$scripttext"
        sleep 0.3
    done
    sleep 7
    for ((i = ${#s[ptx]} - 1; i >= 0; i--)); do
        ans="${ans:0:i}"
	echo "$ans"
        echo "$ans" > "$scripttext"
        sleep 0.2
    done
    ptx=$((ptx + 1))
    if [ $ptx -eq ${#s[@]} ]; then
        ptx=0
    fi
done

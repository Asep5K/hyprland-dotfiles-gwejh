#!/bin/bash

s=(
"Please don't touch my PC, seriously!"
"sudo pacman -S girlfriend --noconfirm"
"Error 404: Girlfriend not found."
"I love you, but I need to go to sleep now."
"I am not a bot, I am a real person!."
"I wish I had an angel for one moment of love."
"Installing happiness... please wait."
"Life is short, update your software."
) 

scripttext=~/.config/hypr/scripts/text_animation/bijilu
ptx=0

while [ $ptx -lt ${#s[@]} ]; do
    ans=""
    for ((i = 0; i < ${#s[ptx]}; i++)); do
        ans+="${s[ptx]:i:1}"
	echo "$ans"
        echo "$ans" > "$scripttext"
        sleep 0.3
    done
    sleep 10
    for ((i = ${#s[ptx]} - 1; i >= 0; i--)); do
        ans="${ans:0:i}"
	echo "$ans"
        echo "$ans" > "$scripttext"
        sleep 0.3
    done
    ptx=$((ptx + 1))
    if [ $ptx -eq ${#s[@]} ]; then
        ptx=0
    fi
done

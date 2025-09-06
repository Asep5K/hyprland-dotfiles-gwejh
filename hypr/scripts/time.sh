#!/usr/bin/env bash

f="/var/lib/AccountsService/icons/$USER"


notify-send -t 5000 -i "$f"  "DATE & TIME" "$(LC_TIME=en_US.UTF-8 date '+%A,%B %d,%Y\n%H:%M:%S')"



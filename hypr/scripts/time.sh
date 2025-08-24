#!/usr/bin/bash
notify-send -t 5000 "DATE & TIME" "$(LC_TIME=en_US.UTF-8 date '+%A,%B %d,%Y\n%H:%M:%S')"



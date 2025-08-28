#!/bin/bash

foto="$HOME/Pictures/kurumi/foto_008.jpg"

notify-send -t 5000 -i "$foto" -a "Jam" "DATE & TIME" "$(LC_TIME=en_US.UTF-8 date '+%A,%B %d,%Y\n%H:%M:%S')"



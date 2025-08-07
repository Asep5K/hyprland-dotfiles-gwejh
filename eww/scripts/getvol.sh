#!/bin/bash

while true; do
  vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')
  is_muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo "true" || echo "false")

  if [ "$is_muted" = "true" ]; then
    icon="󰖁"
    vol=0
  else
    icon="󰕾"
  fi

  eww update get_vol=$vol
  eww update volico=\"$icon\"

  sleep 2
done

#!/bin/bash

if pgrep -x eww  > /dev/null; then
  pkill eww
else
  eww open bar_widget
fi

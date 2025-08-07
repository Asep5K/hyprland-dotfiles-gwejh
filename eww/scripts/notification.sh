#!/bin/bash

msg="$1"

eww update notification_text="$msg"
eww open notif
sleep 4
eww close notif
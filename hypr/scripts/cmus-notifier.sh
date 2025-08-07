#!/bin/bash

last_track=""

while true; do
    file=$(cmus-remote -Q | grep '^file ' | cut -d ' ' -f 2-)
    title=$(cmus-remote -Q | grep '^tag title ' | cut -d ' ' -f 3-)
    artist=$(cmus-remote -Q | grep '^tag artist ' | cut -d ' ' -f 3-)
    track="${artist} - ${title}"

    if [[ "$track" != "$last_track" && -n "$title" ]]; then
        cover="/tmp/cover.jpg"
        ffmpeg -y -i "$file" -an -vcodec copy "$cover" 2>/dev/null

        if [[ -f "$cover" ]]; then
            notify-send -i "$cover" "$artist" "$title"
        else
            notify-send "$artist" "$title"
        fi

        last_track="$track"
    fi

    sleep 1
done


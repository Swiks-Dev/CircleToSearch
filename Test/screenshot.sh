#!/usr/bin/env bash

SAVE_DIR="$HOME/Pictures/.CircleToSearch"

if [ -d "$SAVE_DIR" ]; then
    find "$SAVE_DIR" -mindepth 1 -delete
else
    mkdir -p "$SAVE_DIR"
fi

TAB_OPENED=false

while true; do
    TIMESTAMP=$(date +'%Y%m%d_%H%M%S')
    OUTPUT="$SAVE_DIR/CTS_$TIMESTAMP.png"

    spectacle -r -b -n -k -o "$OUTPUT"

    if [ ! -f "$OUTPUT" ]; then
        notify-send "Circle to Search" "Circle to search Stopped"
        break
    fi

    # Close previous browser tab if one was already opened in this loop
    if [ "$TAB_OPENED" = true ]; then
        if command -v wtype &>/dev/null; then
            wtype -M ctrl -k w
        elif command -v xdotool &>/dev/null; then
            xdotool key ctrl+w
        fi
        sleep 0.3
    fi

    # Upload image to temporary host and open in Google Lens
    xdg-open "https://lens.google.com/uploadbyurl?url=$(curl -s -F 'reqtype=fileupload' -F "fileToUpload=@$OUTPUT" https://catbox.moe/user/api.php)"

    TAB_OPENED=true
done
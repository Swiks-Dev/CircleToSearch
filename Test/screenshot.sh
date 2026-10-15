#!/usr/bin/env bash

SAVE_DIR=$(mktemp -d /tmp/circle_to_search.XXXXXX)

trap 'rm -rf "$SAVE_DIR"' EXIT

while true; do
    TIMESTAMP=$(date +'%Y%m%d_%H%M%S')
    OUTPUT="$SAVE_DIR/CTS_$TIMESTAMP.png"

    spectacle -r -b -n -k -o "$OUTPUT"

    if [ ! -f "$OUTPUT" ]; then
        notify-send "Circle to Search" "Circle to search Stopped"
        break
    fi


    # Upload image to temporary host and open in Google Lens
    xdg-open "https://lens.google.com/uploadbyurl?url=$(curl -s -F 'reqtype=fileupload' -F "fileToUpload=@$OUTPUT" https://catbox.moe/user/api.php)"

done
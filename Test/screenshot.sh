#!/usr/bin/env bash

SAVE_DIR="$HOME/Pictures/.CircleToSearch"

if [ -d "$SAVE_DIR" ]; then
    find "$SAVE_DIR" -mindepth 1 -delete
else
    mkdir -p "$SAVE_DIR"
fi

while true; do

    TIMESTAMP=$(date +'%Y%m%d_%H%M%S')
    OUTPUT="$SAVE_DIR/CTS_$TIMESTAMP.png"

    spectacle -r -b -n -k -o "$OUTPUT"


    if [ ! -f "$OUTPUT" ]; then
        notify-send "Circle to Search" "Circle to search Breaked"
        break
    fi
done
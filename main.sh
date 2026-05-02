#!/bin/bash
ACTIVE=$1

if [ "$ACTIVE" == "true" ]; then
    gnome-terminal
    exit 0
else
    WINDOW_ID=$(wmctrl -l | grep -i "Terminal" | head -n 1 | awk '{print $1}')
    if [ -z "$WINDOW_ID" ]; then
        gnome-terminal
    else
        wmctrl -i -a "$WINDOW_ID"
    fi
fi


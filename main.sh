#!/bin/bash
ACTIVE=$1
CHOICE_TERMINAL=("gnome-terminal" "kitty" "konsole" "xfce4-terminal" "terminator" "urxvt")
for i in "${CHOICE_TERMINAL[@]}"; do
    I_TERMINAL=$(command -v $i)
    if [ -z "$I_TERMINAL" ]; then
        continue
    else
        CURRENT_TERMINAL=$i
        break
    fi
done
if [ -z "$CURRENT_TERMINAL" ]; then
    echo "No supported terminal found"
    exit 1
fi
if [ "$ACTIVE" == "true" ]; then
    $CURRENT_TERMINAL &
    exit 0
elif [ "$ACTIVE" != "true" ]; then
    WINDOW_ID=$(wmctrl -lx | grep -i "$CURRENT_TERMINAL" | head -n 1 | awk '{print $1}')
    if [ -z "$WINDOW_ID" ]; then
        $CURRENT_TERMINAL &
    else
        wmctrl -i -a "$WINDOW_ID"
    fi
fi
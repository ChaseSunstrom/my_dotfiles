#!/bin/bash

# Absolute path to the wallpaper
WALLPAPER="$HOME/Pictures/Under_Starlit_Sky.png"

# Generate the color scheme using wal
wal -i $WALLPAPER

# Take a screenshot and blur it
scrot /tmp/screen.png
convert /tmp/screen.png -blur 0x8 /tmp/screen.png

# Overlay the wallpaper
convert /tmp/screen.png $WALLPAPER -gravity center -composite -matte /tmp/screen.png

# Get the colors from wal
source ~/.cache/wal/colors.sh

# Lock the screen with i3lock-color using wal colors
i3lock \
  --insidever-color=${color0}ff \
  --insidewrong-color=${color1}ff \
  --inside-color=${color0}ff \
  --ringver-color=${color3}ff \
  --ringwrong-color=${color1}ff \
  --ring-color=${color4}ff \
  --line-uses-inside \
  --keyhl-color=${color2}ff \
  --bshl-color=${color1}ff \
  --separator-color=${color1}ff \
  --verif-color=${color7}ff \
  --wrong-color=${color7}ff \
  --time-color=${color7}ff \
  --date-color=${color7}ff \
  --layout-color=${color7}ff \
  --screen 1 \
  --blur 5 \
  --clock \
  --indicator \
  -i /tmp/screen.png

# Remove the temporary image
rm /tmp/screen.png

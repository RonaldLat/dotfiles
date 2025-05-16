#!/bin/bash

background_image="/home/ronald/dotfiles/wallpaper/choco.png"
resized_image="/home/ronald/dotfiles/wallpaper/choco.png"
screen_width=$(xrandr | grep '*' | awk '{print $1}' | cut -d'x' -f1)
screen_height=$(xrandr | grep '*' | awk '{print $1}' | cut -d'x' -f2)

magick "$background_image" -resize "${screen_width}x${screen_height}!" "$resized_image"

i3lock -i "$resized_image"

rm "$resized_image"

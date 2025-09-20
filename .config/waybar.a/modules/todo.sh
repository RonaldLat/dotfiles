#!/bin/sh

TODO_FILE="${XDG_DATA_HOME:-$HOME/.local/share}/todo.txt"
if [ -n "$1" ]; then
	echo "$@" >> "$TODO_FILE"
else
	"${EDITOR:-vi}" "$TODO_FILE"
fi
pkill -RTMIN+7 waybar # update status bar

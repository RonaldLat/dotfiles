#!/bin/sh

# Function to run a command only if it's not already running
run() {
  if ! pgrep -f "$1" ; then
    "$@"&
  fi
}

# Your autostart applications go here
# Example: run "nm-applet"
# Example: run "picom"

# sh ~/dotfiles/.fehbg
run "feh &"
run "picom &"

# run "xautolock -time 10 -locker  \"/home/ronald/.local/bin/lock\" &"

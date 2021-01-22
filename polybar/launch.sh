#!/bin/bash

# Terminate already running instances...
killall -q polybar

# ...and wait for them to actually be dead
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch polybar on each connected monitor
for m in $(polybar --list-monitors | cut -d":" -f1); do
  MONITOR=$m polybar --config=$HOME/.polybar/config --reload arch &
done

#!/bin/bash

killall -q polybar

# Launch polybar on each connected monitor
for m in $(polybar --list-monitors | cut -d":" -f1); do
  MONITOR=$m polybar --config=$HOME/.polybar/config --reload arch &
done

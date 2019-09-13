#!/bin/bash

# Launch polybar on each connector monitor
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --config=~/.polybar/config --reload arch &
  done
else
  polybar --config=~/.polybar/config --reload arch &
fi

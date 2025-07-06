#!/bin/bash

# 自宅モニタ用
xrandr \
  --output eDP-1 --mode 1920x1080 \
  --output DP-1 --mode 1920x1080 --same-as eDP-1

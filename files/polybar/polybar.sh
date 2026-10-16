#!/bin/bash

# Terminate already running bar instances
killall -q polybar
killall -q snixembed

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.2; done

# Launch Polybar, using default config location ~/.config/polybar/config
polybar mybar &

# Bridge StatusNotifierItem icons (e.g. equibop) into polybar's XEmbed-only tray.
# Started after polybar so the tray exists when it starts embedding icons.
(sleep 1 && @snixembed@ --fork) &

echo "Polybar launched..."

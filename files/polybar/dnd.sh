#!/usr/bin/env bash

dnd_status=$(dunstctl is-paused)

if [[ $dnd_status == true ]]
then
    # colors.green in polybar/config.ini
    echo ' 󰪑 '
else
    echo " 󰂚 "
fi

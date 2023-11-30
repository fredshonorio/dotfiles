#!/usr/bin/env bash

# inspired by
# https://forum.manjaro.org/t/how-to-one-click-toggle-for-do-not-disturb-mode-for-xfce-notifications/143410

dnd_status=$(xfconf-query -c xfce4-notifyd -p /do-not-disturb)

if [[ $dnd_status == true ]]
then
    # colors.green in polybar/config.ini
    echo '%{F#A6E22E}dnd!%{F-}'
else
    echo "dnd"
fi

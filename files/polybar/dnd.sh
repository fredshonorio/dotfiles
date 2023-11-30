#!/usr/bin/env bash

# inspired by
# https://forum.manjaro.org/t/how-to-one-click-toggle-for-do-not-disturb-mode-for-xfce-notifications/143410

dnd_status=$(xfconf-query -c xfce4-notifyd -p /do-not-disturb)

if [[ $dnd_status == true ]]
then
    echo "dnd:on"
else
    echo "dnd:off"
fi

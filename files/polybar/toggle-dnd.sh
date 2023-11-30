#!/usr/bin/bash

# inspired by
# https://forum.manjaro.org/t/how-to-one-click-toggle-for-do-not-disturb-mode-for-xfce-notifications/143410

xfconf-query -c xfce4-notifyd -p /do-not-disturb -T

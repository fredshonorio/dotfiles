#!/bin/bash

killall xfdesktop xfwm4 xfce4-panel
xmonad --replace

yay -R xfdesktop xfwm4
# make xfce4-panel not executable
sudo chmod a-rwx /usr/bin/xfce4-panel

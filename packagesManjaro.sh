#!/bin/bash

function yay-needed() {
    yay -S $(yay -Qi $1 2>&1 >/dev/null | grep "error: package" | grep "was not found" | cut -d"'" -f2 | tr "\n" " ")
}

# fonts
yay-needed ttf-meslo-nerd-font-powerlevel10k
yay-needed ttf-iosevka-nerd
yay-needed ttf-droid
## for discord
yay-needed noto-fonts-cjk  
yay-needed noto-fonts-emoji
# shell
yay-needed wezterm
yay-needed zsh
yay-needed tree
yay-needed the_silver_searcher
yay-needed fzf
yay-needed bat
# git
yay-needed gitg
yay-needed git-delta
yay-needed gitui
yay-needed zoxide
# desktop
yay-needed xmonad
yay-needed xmonad-contrib
yay-needed feh
yay-needed polybar
yay-needed rofi
yay-needed xbindkeys
yay-needed playerctl
yay-needed flameshot
yay-needed xfce4-pulseaudio-plugin
## for volume keys
yay-needed xfce4-volumed-pulse
yay-needed systembus-notify
yay-needed earlyoom
# comms
yay-needed discord
yay-needed signal-desktop
# dev misc
yay-needed terraform
yay-needed make
yay-needed meld
yay-needed gum
yay-needed docker-compose
# dev python
yay-needed python-pipenv
yay-needed pyenv
# dev scala
yay-needed sbt
# dev js
yay-needed nvm
# misc
yay-needed obsidian
yay-needed syncthing

#
# AUR packages
#

yay-needed antibody-bin
# yay-needed syncthingtray TODO: gtk
yay-needed pacman-cleanup-hook
yay-needed xmonad-recompile-pacman-hook-git
yay-needed visual-studio-code-bin
yay-needed spotify
yay-needed ttf-symbola # for discord
yay-needed xmonad-log # read xmonad status from dbus, for polybar
yay-needed xmonad-dbus-git

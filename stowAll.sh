#!/bin/sh

set -ex

first_char=$(hostname | cut -c1)

# laptop stuff
if [ "$first_char" = "l" ]; then
    sudo stow -t / disable-caps-lock
    stow xbindkeys-laptop

    # prevent headphone buzz when no audio is playing
    sudo stow -t / disable-audio-powersave
    # systemctl start disable-audio-powersave
    # systemctl enable disable-audio-powersave
fi


stow \
    git \
    sakura \
    xmonad \
    xmobar \
    wezterm \
    terraform \
    zsh \
    user-bin \
    autostart

sudo stow -t / google-drive
sudo stow -t /etc/default earlyoom
sudo stow -t /etc/systemd/system/docker.service.d docker

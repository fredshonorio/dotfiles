#!/bin/sh

set -ex

first_char=$(hostname | cut -c1)

# laptop stuff
if [ "$first_char" = "l" ]
then
    sudo stow -t / disable-caps-lock
    stow xbindkeys-laptop

    # prevent headphone buzz when no audio is playing
    sudo stow -t / disable-audio-powersave
    # systemctl start disable-audio-powersave
    # systemctl enable disable-audio-powersave
else
    stow xbindkeys
fi

# work stuff
if [ "$first_char" = "w" ]; then
    sudo stow -t /etc/systemd/system/docker.service.d docker
fi

stow \
    git \
    xmonad \
    wezterm \
    terraform \
    zsh \
    user-bin \
    rofi \
    autostart


# delete installed config
if [ ! -L "/etc/default/earlyoom" ]; then
    echo "deleting non-link file /etc/default/earlyoom"
    sudo rm /etc/default/earlyoom
fi

sudo stow -t /etc/default earlyoom

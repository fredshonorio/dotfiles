#!/bin/sh

set -ex

first_char=$(hostname | cut -c1)

# laptop stuff
if [ "$first_char" = "l" ]
then
    stow xbindkeys-laptop

    # prevent headphone buzz when no audio is playing
    sudo stow -t / disable-audio-powersave
    # systemctl start disable-audio-powersave
    # systemctl enable disable-audio-powersave
else
    stow xbindkeys
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

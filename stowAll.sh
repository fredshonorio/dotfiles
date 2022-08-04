#!/bin/sh

set -ex

first_char=$(hostname | cut -c1)

# laptop stuff
if [ "$first_char" = "l" ]; then
	sudo stow -t / disable-caps-lock
	stow xbindkeys-laptop
fi


stow \
	git \
	sakura \
	xmonad \
	xmobar \
	wezterm \
	terraform \
	zsh \
    autostart

sudo stow -t / google-drive

#!/bin/sh

set -ex

first_char=$(hostname | cut -c1)

if [ "$first_char" = "w" ]; then
	stow \
		xmobar-desktop
fi


stow \
	zsh \
	sakura \
	xmonad \
	kitty

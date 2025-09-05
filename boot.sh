#!/bin/sh

set -ex

#tailscale
#devbox-bin
#coursier-bin, $ coursier setup
#jetbrains-toolbox


sudo pacman --needed -S yay
sudo yay -S coursier-bin

export PATH="$HOME/.local/share/coursier/bin:$PATH"

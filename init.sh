#!/bin/sh

set -ex

#
# This should be run only the first time zsh and docker are set up
#


sudo pacman -Syu
sudo pacman --needed -S yay
sudo pacman --needed -S chezmoi

chezmoi apply

# Change shell 
sudo chsh -s $(which zsh) $USER

echo "You should close this terminal and open a new one now."

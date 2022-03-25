#!/bin/sh

#
# This should be run only the first time nix and zsh is set up
#

set -ex

sudo pacman --needed -S yay

./packagesManjaro.sh

# Add current zsh (in this nix session) to login shells
command -v zsh | sudo tee -a /etc/shells

# Change shell 
sudo chsh -s $(which zsh) $USER

./stowAll.sh
./bundleZsh.sh

echo "You should close this terminal and open a new one now."

#!/bin/sh

#
# This should be run only the first time nix and zsh is set up
#

set -ex

sudo pacman --needed -S yay

./packagesManjaro.sh

# Change shell 
sudo chsh -s $(which zsh) $USER

./update.sh

echo "You should close this terminal and open a new one now."

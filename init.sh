#!/bin/sh

set -ex

#
# This should be run only the first time zsh and docker are set up
#


sudo pacman -Syu
sudo pacman --needed -S yay nix

ln -s ~/.dotfiles ~/.config/home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

# Change shell 
sudo chsh -s $(which zsh) $USER

echo "You should close this terminal and open a new one now. Then run ./update.sh."

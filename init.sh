#!/bin/sh

#
# This should be run only the first time nix and zsh is set up
#

set -ex

sudo pacman -Syu

sudo pacman --needed -S yay

# docker
sudo pacman --needed -S docker
sudo usermod -aG docker $USER
sudo systemctl enable docker
sudo mkdir /etc/systemd/system/docker.service.d
# docker won't work unless you restart

./packagesManjaro.sh

# Change shell 
sudo chsh -s $(which zsh) $USER

./update.sh

echo "You should close this terminal and open a new one now."

#!/bin/sh

#
# This should be run only the first time nix and zsh is set up
#

set -ex

# Install Nix
sh <(curl -L https://nixos.org/nix/install) --no-daemon
. ~/.nix-profile/etc/profile.d/nix.sh

# Workaround for nix-env bug https://github.com/NixOS/nixpkgs/issues/163374#issuecomment-1069598111
echo '""'  > ~/.empty.nix
NIX_PATH=$NIX_PATH:REPEAT=$HOME/.empty.nix

sudo pacman --needed -S yay

./packagesNixEnv.sh

# Add current zsh (in this nix session) to login shells
command -v zsh | sudo tee -a /etc/shells

# Change shell 
sudo chsh -s $(which zsh) $USER

./stowAll.sh
./bundleZsh.sh
./packagesManjaro.sh

echo "You should close this terminal and open a new one now."


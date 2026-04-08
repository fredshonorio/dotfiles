#!/bin/sh

set -ex

# this script should be idempotent

# sudo pacman -Syu
sudo pacman --needed -S yay

ln -sfn ~/.dotfiles ~/.config/home-manager
ln -sf "host-$(hostname).nix" ~/.dotfiles/home.nix # home.nix is gitignored, it's different for each host

NIXPKGS_VERSION="25.11"
nix-channel --add https://github.com/nix-community/home-manager/archive/release-${NIXPKGS_VERSION}.tar.gz home-manager
nix-channel --update

if ! command -v home-manager > /dev/null 2>&1; then
  nix-shell '<home-manager>' -A install
fi

# Change shell 
sudo chsh -s $(which zsh) $USER

echo "You should close this terminal and open a new one now. Then run ./update.sh."

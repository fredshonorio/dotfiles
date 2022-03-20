#!/bin/sh

sh <(curl -L https://nixos.org/nix/install) --no-daemon

./packages.sh

command -v zsh | sudo tee -a /etc/shells
sudo chsh -s $(which zsh) $USER

./stowAll.sh
./bundleZsh.sh


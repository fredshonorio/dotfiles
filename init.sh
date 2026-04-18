#!/bin/sh

set -ex

# this script should be idempotent

# sudo pacman -Syu
if ! command -v yay > /dev/null 2>&1; then
  sudo pacman -S yay
fi

if ! command -v aconfmgr > /dev/null 2>&1; then
  yay -S aconfmgr-git
fi

# add user to docker group (one-time)
if ! groups $USER | grep -q docker; then
  sudo usermod -aG docker $USER
fi

if ! command -v nix > /dev/null 2>&1; then
  sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
fi

if ! command -v home-manager > /dev/null 2>&1; then
  nix run home-manager/master -- init --switch
fi

home-manager switch --flake ~/.dotfiles#fred@$(hostname)

# Change shell 
if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s $(which zsh) $USER
fi

# remove XFCE's Print shortcut so xmonad can handle it
xfconf-query -c xfce4-keyboard-shortcuts -p '/commands/custom/Print' -r 2>/dev/null || true

echo "You should close this terminal and open a new one now. Then run ./update.sh."

#!/usr/bin/env bash


yay --needed -S \
    ttf-meslo-nerd-font-powerlevel10k \
    git-delta \
    tig \
    zsh \
    fzf \
    zoxide \
    stow \
    nvm \
    direnv \
    terraform \
    howl

#
# AUR packages
#

function yay-needed() {
    yay -S $(yay -Qi $1 2>&1 >/dev/null | grep "error: package" | grep "was not found" | cut -d"'" -f2 | tr "\n" " ")
}

yay-needed antibody-bin
yay-needed git-standup-git
yay-needed google-drive-ocamlfuse-opam
yay-needed pacman-cleanup-hook
yay-needed xmonad-recompile-pacman-hook-git

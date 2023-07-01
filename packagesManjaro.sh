#!/usr/bin/env bash


yay --needed -S \
    ttf-meslo-nerd-font-powerlevel10k \
    ttf-iosevka-nerd \
    ttf-droid \
    git-delta \
    gitui \
    tig \
    zsh \
    fzf \
    zoxide \
    stow \
    earlyoom \
    systembus-notify \
    nvm \
    direnv \
    xmonad \
    xmonad-contrib \
    feh \
    terraform \
    howl \
    meld \
    xbindkeys \
    copyq \
    signal-desktop \
    polybar \
    discord \
    wezterm \
    rofi \
    bat \
    obsidian \
    syncthing

#
# AUR packages
#

function yay-needed() {
    yay -S $(yay -Qi $1 2>&1 >/dev/null | grep "error: package" | grep "was not found" | cut -d"'" -f2 | tr "\n" " ")
}

yay-needed antibody-bin
yay-needed syncthingtray
yay-needed pacman-cleanup-hook
yay-needed xmonad-recompile-pacman-hook-git
yay-needed visual-studio-code-bin
# yay-needed python-pssh # for 'c-ps' alias
# polybar
yay-needed xmonad-log # read xmonad status from dbus
# yay-needed siji-ttf   # icons -- TODO: see if this is necessary

#
# services
#

function systemctl-enable-needed() {
    if ! systemctl is-enabled $1 | grep enabled; then
        systemctl enable --now $1
    fi
}

systemctl-enable-needed earlyoom

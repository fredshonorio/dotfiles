#!/usr/bin/env bash


yay --needed -S \
    `# fonts` \
    ttf-meslo-nerd-font-powerlevel10k \
    ttf-iosevka-nerd \
    ttf-droid \
    noto-fonts-cjk   `# for discord` \
    noto-fonts-emoji `# for discord` \
    `# shell` \
    wezterm \
    zsh \
    tree \
    the_silver_searcher \
    fzf \
    stow \
    direnv \
    bat \
    `# git` \
    gitg \
    git-delta \
    gitui \
    gitui \
    zoxide \
    `# desktop` \
    xmonad \
    xmonad-contrib \
    feh \
    polybar \
    rofi \
    xbindkeys \
    playerctl \
    howl \
    flameshot \
    xfce4-pulseaudio-plugin \
    xfce4-volumed-pulse `# for volume keys` \
    systembus-notify \
    earlyoom \
    `# comms` \
    discord \
    signal-desktop \
    `# dev misc` \
    terraform \
    make \
    meld \
    gum \
    docker-compose \
    `# dev python` \
    python-pipenv \
    pyenv \
    `# dev scala` \
    sbt \
    `# dev js` \
    nvm \
    `# misc` \
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
yay-needed spotify
yay-needed ttf-symbola # for discord
yay-needed xmonad-log # read xmonad status from dbus, for polybar
yay-needed xmonad-dbus-git
#
# services
#

function systemctl-enable-needed() {
    if ! systemctl is-enabled $1 | grep enabled; then
        systemctl enable --now $1
    fi
}

systemctl-enable-needed earlyoom

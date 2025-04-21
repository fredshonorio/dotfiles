#! /bin/bash
set -euo pipefail

# utilities

enable-systemd-service () {
    svc="$1"
    if [ -z $(systemctl is-enabled $svc | grep enabled) ]; then
        sudo systemctl enable $svc
    fi
}

replace-file-su () {
    local src="out-of-home-files/$1"
    local dst="$2"
    sudo rsync $src $dst
}

yay-needed() {
    pkg="$1"
    yay -S $(yay -Qi $pkg 2>&1 >/dev/null | grep "error: package" | grep "was not found" | cut -d"'" -f2 | tr "\n" " ")
}

# create a file if it doesn't exist, fail if it differs
ensure-file () {
    local src="out-of-home-files/$1"
    local dst="$2"

    if [[ ! -f "$dst" ]]; then # destination doesn't exist, copy
        rsync "$src" "$dst"
    else
        if cmp --silent -- "$dst" "$src"; then
            echo -e "\e[32m'$dst': exists and is identical\033[0m"
        else
            echo -e "\e[31m'$dst': exists but doesn't match\033[0m"
            echo "Helpful commands:"
            echo "meld '$src' '$dst'"
            echo "cp '$dst' '$src'"
            exit 1
        fi
    fi
}

#
# docker
yay-needed docker
if [ -z "$(groups $USER | grep docker)" ]; then # add user to group
    sudo usermod -aG docker $USER
fi
sudo mkdir -p /etc/systemd/system/docker.service.d
replace-file-su "docker-override.conf" "/etc/systemd/system/docker.service.d/override.conf"
enable-systemd-service "docker"

#
# earlyoom
replace-file-su "earlyoom" "/etc/default/earlyoom"
enable-systemd-service "earlyoom"

#
# /usr/local/bin
replace-file-su "workfox" "/usr/local/bin/workfox"

#
# caps lock
replace-file-su "disable-caps-lock.sh" "/etc/X11/xinit/xinitrc.d/99-disable-caps-lock.sh"

#
# intellij 
# technically in $HOME, but not managed by home manager because idk how IJ
# handles a file with no write permissions
# ensure-file xwin-copy.xml "$HOME/.config/JetBrains/IdeaIC2023.3/keymaps/XWin copy.xml"

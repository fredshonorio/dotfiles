/bin/zsh
set -euxo pipefail

# utilities

enable-systemd-service () {
    svc="$1"
    if [ -z $(systemctl is-enabled $svc | grep enabled) ]; then
        sudo systemctl enable $svc
    fi
}

replace-file-su () {
    src="out-of-home-files/$1"
    dst="$2"
    sudo rsync $src $dst
}

yay-needed() {
    pkg="$1"
    yay -S $(yay -Qi $pkg 2>&1 >/dev/null | grep "error: package" | grep "was not found" | cut -d"'" -f2 | tr "\n" " ")
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

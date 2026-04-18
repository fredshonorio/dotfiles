IgnorePath '/var/*'
IgnorePath '/nix/*'
IgnorePath '/boot/*'
IgnorePath '/opt/*'
IgnorePath '/.manjaro-tools'
IgnorePath '/desktopfs-pkgs.txt'
IgnorePath '/rootfs-pkgs.txt'

etc_whitelist=(
    'systemd/system/docker.service.d/override.conf'
    'default/earlyoom'
    'X11/xinit/xinitrc.d/99-disable-caps-lock.sh'
    'systemd/system/multi-user.target.wants/docker.service'
    'systemd/system/multi-user.target.wants/earlyoom.service'
)

IgnorePathsExcept /etc "${etc_whitelist[@]}"

# docker service override
CopyFile /etc/systemd/system/docker.service.d/override.conf

# earlyoom config
CopyFile /etc/default/earlyoom

# caps lock disable (runs in xinitrc.d)
CopyFile /etc/X11/xinit/xinitrc.d/99-disable-caps-lock.sh 755

# systemd service enables
CreateLink /etc/systemd/system/multi-user.target.wants/docker.service /usr/lib/systemd/system/docker.service
CreateLink /etc/systemd/system/multi-user.target.wants/earlyoom.service /usr/lib/systemd/system/earlyoom.service


usr_whitelist=(
    'local/bin/workfox'
)

IgnorePathsExcept /usr "${usr_whitelist[@]}"

# workfox: firefox work profile launcher
CopyFile /usr/local/bin/workfox 755

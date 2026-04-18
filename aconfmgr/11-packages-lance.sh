if [[ "$HOSTNAME" != "lance" ]]; then return; fi

AddPackage calibre
AddPackage intel-media-driver
AddPackage intel-ucode
AddPackage lib32-libva-intel-driver
AddPackage linux612
AddPackage lib32-vulkan-intel
AddPackage qbittorrent
AddPackage smartmontools
AddPackage thermald
AddPackage tlp
AddPackage xf86-input-synaptics
AddPackage xfce4-volumed-pulse

AddPackage --foreign imagewriter
AddPackage --foreign jdownloader2
AddPackage --foreign losslesscut-bin

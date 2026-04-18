if [[ "$HOSTNAME" != "lance" ]]; then return; fi

AddPackage intel-ucode
AddPackage lib32-libva-intel-driver
AddPackage lib32-vulkan-intel

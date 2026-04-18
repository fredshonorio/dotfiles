if [[ "$HOSTNAME" != "whale" ]]; then return; fi

# gpu
AddPackage lib32-nvidia-utils
AddPackage nvidia-container-toolkit
AddPackage nvidia-settings
AddPackage nvidia-utils

# audio
AddPackage easyeffects
AddPackage ladspa
AddPackage lsp-plugins
AddPackage --foreign libdeep_filter_ladspa-bin

AddPackage android-tools
AddPackage amd-ucode
AddPackage --foreign deadbranch-bin
AddPackage --foreign google-chrome-beta
AddPackage --foreign jdk24-graalvm-ce-bin
AddPackage --foreign lmstudio-bin
AddPackage opencode

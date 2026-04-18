if [[ "$HOSTNAME" != "whale" ]]; then return; fi

AddPackage amd-ucode
AddPackage --foreign deadbranch-bin
AddPackage --foreign google-chrome-beta
AddPackage --foreign jdk24-graalvm-ce-bin
AddPackage lib32-nvidia-utils
AddPackage --foreign lmstudio-bin
AddPackage nvidia-container-toolkit
AddPackage nvidia-settings
AddPackage nvidia-utils
AddPackage lsp-plugins
AddPackage ladspa

AddPackage easyeffects
AddPackage --foreign libdeep_filter_ladspa-bin
AddPackage opencode

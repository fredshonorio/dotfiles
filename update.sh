#!/bin/sh

#
# This can be run every time the list of packages and antibody plugins is changed
#

./packagesManjaro.sh
./stowAll.sh

# Bundle plugins in .zsh_plugins.txt to be loaded by the shell
# https://getantibody.github.io/usage/

antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh

# Prepare terraform provider cache
mkdir -p ~/.terraform.d/plugin-cache

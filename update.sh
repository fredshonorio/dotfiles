#!/bin/sh

set -ex

#
# This script can be run every time this repository is updated
#

./packagesManjaro.sh
./stowAll.sh

#
# Shell
#
## Bundle plugins in .zsh_plugins.txt to be loaded by the shell
## https://getantibody.github.io/usage/

antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh


#
# Terraform
#
## Prepare terraform provider cache

mkdir -p ~/.terraform.d/plugin-cache


#
# Google Drive
#
## Prepare directory

mkdir -p ~/mount/Obsidian

#!/bin/sh

set -ex

#
# This script can be run every time this repository is updated
#

# system packages and config files
aconfmgr -c ~/.dotfiles/aconfmgr apply

#
# Home manager
#

home-manager switch

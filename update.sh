#!/bin/sh

set -ex

#
# This script can be run every time this repository is updated
#

./packagesManjaro.sh

#
# Home manager
#

home-manager switch # TODO: fix, check if host-<hostname>.nix file exists and use it

#
# out of home config
#

./out-of-home.sh

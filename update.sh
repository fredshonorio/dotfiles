#!/bin/sh

#
# This can be run every time the list of packages and antibody plugins is changed
#

./packages.sh
./stowAll.sh
./bundleZsh.sh

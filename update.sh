#!/bin/sh

set -ex

#
# This script can be run every time this repository is updated
#

./packagesManjaro.sh

#
# Home manager
#

home-manager switch

#
# out of home config
#

./out-of-home.sh

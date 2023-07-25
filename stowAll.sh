#!/bin/sh

set -ex

# delete installed config
if [ ! -L "/etc/default/earlyoom" ]; then
    echo "deleting non-link file /etc/default/earlyoom"
    sudo rm /etc/default/earlyoom
fi

sudo stow -t /etc/default earlyoom

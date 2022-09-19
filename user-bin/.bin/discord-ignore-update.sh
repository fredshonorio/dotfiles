#!/bin/bash

tmp=$(mktemp)
cfg="$HOME/.config/discord/settings.json"

jq '. += {"SKIP_HOST_UPDATE":true}' $cfg > $tmp

rm $cfg

cp $tmp $cfg


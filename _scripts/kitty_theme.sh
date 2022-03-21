#!/bin/bash

THEME=$1
THEME_DIR=~/.config/kitty/themes

set -ex

cd $THEME_DIR && wget https://raw.githubusercontent.com/dexpota/kitty-themes/master/themes/$THEME.conf

sed -i "s/^include \.\/themes.*$/include .\/themes\/$THEME.conf/" ~/.config/kitty/kitty.conf

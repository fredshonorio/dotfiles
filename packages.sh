#!/bin/sh

nix-env -iA \
	nixpkgs.zsh \
	nixpkgs.antibody \
	nixpkgs.direnv

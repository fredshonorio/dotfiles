#!/bin/sh

nix-env -iA \
	nixpkgs.zsh \
	nixpkgs.glibcLocales \
	nixpkgs.antibody \
	nixpkgs.stow \
	nixpkgs.neovim \
	nixpkgs.direnv

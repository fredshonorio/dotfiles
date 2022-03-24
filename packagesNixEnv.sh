#!/bin/sh

nix-env -iA \
	nixpkgs.zsh \
	nixpkgs.glibcLocales \
	nixpkgs.antibody \
	nixpkgs.stow \
	nixpkgs.direnv

nix-env --uninstall neovim

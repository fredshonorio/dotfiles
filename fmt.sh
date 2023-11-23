#!/bin/bash

ls *.nix| entr nixfmt *.nix

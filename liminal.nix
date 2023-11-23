{ config, pkgs, lib, ... }:

let
  common = import ./common.nix {
    config = config;
    pkgs = pkgs;
    lib = lib;
  };

in lib.mkMerge [
  common # base
]


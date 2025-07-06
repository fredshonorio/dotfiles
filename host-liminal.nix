{ config, pkgs, lib, myLib, ... }:

let
  myLib = import ./myLib.nix { inherit lib; };
  common = import ./common.nix { inherit config pkgs lib myLib; };

in lib.mkMerge [
  common # base
]


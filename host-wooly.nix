{ config, pkgs, lib, myLib, ... }:

let
  extra = import ./extra.nix { inherit config pkgs lib myLib; };
in
lib.mkMerge [
  extra.autostart.thunderbird
  extra.autostart.workrave
]


{ config, pkgs, lib, ... }:

let
  common = import ./common.nix {
    config = config;
    pkgs = pkgs;
    lib = lib;
  };

  extra = import ./extra.nix {
    config = config;
    pkgs = pkgs;
    lib = lib;
  };

in lib.mkMerge [
  common # base
  {
    home.file =
      extra.files.desktopAudioInterfaceFix; # override (merged recursively)
  }
]


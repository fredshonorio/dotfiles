{ config, pkgs, lib, myLib, ... }:

let
  myLib = import ./myLib.nix { inherit lib; };
  common = import ./common.nix { inherit config pkgs lib myLib; };
  extra = import ./extra.nix { inherit config pkgs lib myLib; };

in lib.mkMerge [
  common # base
  #  { replaced pipewire with pulseaudio because this fix wasn't fixing anything
  #    home.file =
  #      extra.files.desktopAudioInterfaceFix; # override (merged recursively)
  #  }
  extra.thunderbird
]


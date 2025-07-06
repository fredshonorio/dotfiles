{ config, pkgs, lib, myLib, ... }:

let
  mkSingleAuto = name: path: {
    home.file = myLib.autostart { ${name} = path; };
  };
in {
  # homemanager autostart entries
  autostart = {
    thunderbird = mkSingleAuto "thunderbird" "/usr/bin/thunderbird";
    workrave = mkSingleAuto "workrave" "/usr/bin/workrave";
  };

}

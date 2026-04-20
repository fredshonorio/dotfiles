{
  config,
  pkgs,
  lib,
  myLib,
  ...
}:

let
  extra = import ./extra.nix {
    inherit
      config
      pkgs
      lib
      myLib
      ;
  };
in
lib.mkMerge [
  {
    # for AMD
    # $ for i in /sys/class/hwmon/hwmon*/temp*_input; do echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*})) $(readlink -f $i)"; done | grep k10temp
    polybar-hwmonPath = "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon3/temp1_input";
    home.file.".config/git-repo-tray/config.toml".source = ./files/git-repo-tray/config.toml;
  }
  extra.autostart.thunderbird
  extra.autostart.workrave
]

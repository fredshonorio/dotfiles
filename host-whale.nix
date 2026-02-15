{
  config,
  pkgs,
  lib,
  myLib,
  ...
}:

let
  myLib = import ./myLib.nix { inherit lib; };
  common = import ./common.nix {
    inherit
      config
      pkgs
      lib
      myLib
      ;
    # for AMD
    # $ for i in /sys/class/hwmon/hwmon*/temp*_input; do echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*})) $(readlink -f $i)"; done | grep k10temp

    polybar-hwmonPath = "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon3/temp1_input";
  };
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
  common # base
  extra.autostart.thunderbird
]

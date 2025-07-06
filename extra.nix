{ config, pkgs, lib, myLib, ... }:

let
  mkSingleAuto = name: path: {
    home.file = myLib.autostart { ${name} = path; };
  };
in {
  files = {
    # fixes stuttering with the UR22kmII on recent kernels (maybe?)
    desktopAudioInterfaceFix = {
      ".config/wireplumber/main.lua.d/50-alsa-config.lua".source =
        files/wireplumber/50-alsa-config.lua;
    };
  };

  # homemanager autostart entries
  autostart = {
    thunderbird = mkSingleAuto "thunderbird" "/usr/bin/thunderbird";
    workrave = mkSingleAuto "workrave" "/usr/bin/workrave";
  };

}

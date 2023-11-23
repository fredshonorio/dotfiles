{ config, pkgs, lib, ... }:

{
  files = {
    # fixes stuttering with the UR22kmII on recent kernels (maybe?)
    desktopAudioInterfaceFix = {
      ".config/wireplumber/main.lua.d/50-alsa-config.lua".source =
        files/wireplumber/50-alsa-config.lua;
    };
  };

}

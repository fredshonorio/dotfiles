{ config, pkgs, lib, myLib, ... }:

in
{
  home.file.".config/git-repo-tray/config.toml".source = ./files/git-repo-tray/config.toml;
}


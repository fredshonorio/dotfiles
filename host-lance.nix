{ config, pkgs, lib, myLib, ... }:

{
  home.file.".config/git-repo-tray/config.toml".source = ./files/git-repo-tray/config.toml;
}


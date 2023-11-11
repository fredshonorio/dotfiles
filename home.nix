{ config, pkgs, ... }:

{
  home.username = "fred";
  home.homeDirectory = "/home/fred";
  home.stateVersion = "23.05";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  home.file = {
    ".aliases.sh".source = files/HOME/.aliases.sh;
    ".direnvrc".source = files/HOME/.direnvrc;
    ".gitconfig".source = files/HOME/.gitconfig;
    ".p10k.zsh".source = files/HOME/.p10k.zsh;
    ".terraformrc".source = files/HOME/.terraformrc;
    ".xbindkeysrc".source = files/HOME/.xbindkeysrc;
    ".zsh_plugins.txt".source = files/HOME/.zsh_plugins.txt;
    ".zshrc".source = files/HOME/.zshrc;
    
    ".xmonad/xmonad.hs".source = files/HOME/.xmonad/xmonad.hs;
    ".config/autostart/discord.desktop".source = files/HOME/.config/autostart/discord.desktop;
    ".config/autostart/obsidian.desktop".source = files/HOME/.config/autostart/obsidian.desktop;
    ".config/autostart/signal.desktop".source = files/HOME/.config/autostart/signal.desktop;
    ".config/autostart/thunderbird.desktop".source = files/HOME/.config/autostart/thunderbird.desktop;
    ".config/autostart/xbindkeys.desktop".source = files/HOME/.config/autostart/xbindkeys.desktop;
    ".config/autostart/Xmonad.desktop".source = files/HOME/.config/autostart/Xmonad.desktop;
    ".config/polybar/config.ini".source = files/HOME/.config/polybar/config.ini;
    ".config/rofi/config.rasi".source = files/HOME/.config/rofi/config.rasi;
    ".config/wezterm/wezterm.lua".source = files/HOME/.config/wezterm/wezterm.lua;
    ".bin/c-ps".source = files/HOME/.bin/c-ps;
    ".bin/discord-ignore-update.sh".source = files/HOME/.bin/discord-ignore-update.sh;
    ".bin/git-branch-delete-fzf.zsh".source = files/HOME/.bin/git-branch-delete-fzf.zsh;
    ".bin/polybar.sh".source = files/HOME/.bin/polybar.sh;
    ".bin/workfox".source = files/HOME/.bin/workfox;
    ".bin/mgitstatus".source = pkgs.fetchFromGitHub {
        owner = "fboender";
        repo = "multi-git-status";
        rev = "2.2";
        sha256="jzoX7Efq9+1UdXQdhLRqBlhU3cBrk5AZblg9AYetItg=";
    } + "/mgitstatus" ;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/fred/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

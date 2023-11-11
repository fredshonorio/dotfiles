{ config, pkgs, ... }:

{
  home.username = "fred";
  home.homeDirectory = "/home/fred";
  home.stateVersion = "23.05";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.direnv
    pkgs.fzf
    pkgs.nixfmt

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
    # ".aliases.sh".source = files/HOME/.aliases.sh;
    ".direnvrc".source = files/HOME/.direnvrc;
    ".gitconfig".source = files/HOME/.gitconfig;
    # ".p10k.zsh".source = files/HOME/.p10k.zsh;
    ".terraformrc".source = files/HOME/.terraformrc;
    ".xbindkeysrc".source = files/HOME/.xbindkeysrc;
    # ".zsh_plugins.txt".source = files/HOME/.zsh_plugins.txt;
    # ".zshrc".source = files/HOME/.zshrc;

    ".xmonad/xmonad.hs".source = files/HOME/.xmonad/xmonad.hs;
    ".config/autostart/discord.desktop".source =
      files/HOME/.config/autostart/discord.desktop;
    ".config/autostart/obsidian.desktop".source =
      files/HOME/.config/autostart/obsidian.desktop;
    ".config/autostart/signal.desktop".source =
      files/HOME/.config/autostart/signal.desktop;
    ".config/autostart/thunderbird.desktop".source =
      files/HOME/.config/autostart/thunderbird.desktop;
    ".config/autostart/xbindkeys.desktop".source =
      files/HOME/.config/autostart/xbindkeys.desktop;
    ".config/autostart/Xmonad.desktop".source =
      files/HOME/.config/autostart/Xmonad.desktop;
    ".config/polybar/config.ini".source = files/HOME/.config/polybar/config.ini;
    ".config/rofi/config.rasi".source = files/HOME/.config/rofi/config.rasi;
    ".config/wezterm/wezterm.lua".source =
      files/HOME/.config/wezterm/wezterm.lua;
    ".bin/c-ps".source = files/HOME/.bin/c-ps;
    ".bin/discord-ignore-update.sh".source =
      files/HOME/.bin/discord-ignore-update.sh;
    ".bin/git-branch-delete-fzf.zsh".source =
      files/HOME/.bin/git-branch-delete-fzf.zsh;
    ".bin/polybar.sh".source = files/HOME/.bin/polybar.sh;
    ".bin/mgitstatus".source = pkgs.fetchFromGitHub {
      owner = "fboender";
      repo = "multi-git-status";
      rev = "2.2";
      sha256 = "jzoX7Efq9+1UdXQdhLRqBlhU3cBrk5AZblg9AYetItg=";
    } + "/mgitstatus";

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    FZF_CTRL_T_OPTS = "--preview 'bat --color=always --line-range :50 {}'";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh.antidote = {
    enable = true;
    plugins = [
      "robbyrussell/oh-my-zsh path:plugins/nvm" # tab completion for nvm
      # integrate fzf in zsh
      # override Ctrl+R to use fzf
      # alt+c - list directories in pwd then cd into selected one
      # ctrl+t - search current directory and insert the selected file path in the prompt
      "robbyrussell/oh-my-zsh path:plugins/fzf"
      # "robbyrussell/oh-my-zsh path:plugins/pipenv" TODO
      "zsh-users/zsh-autosuggestions" # suggest a matching previous command as you type
      "zsh-users/zsh-completions" # more tab completions (one day I should include only what I use)
      "zsh-users/zsh-syntax-highlighting" # syntax highlighting on the prompt
      "ptavares/zsh-direnv" # direnv hooks for zsh (probably could be a program.)
      # add a jq integration to filter the json output of a program with jq, type the command and then press alt+j
      "reegnz/jq-zsh-plugin"

      # add hooks into zsh so that it shows a notification when a long running (15 seconds) process ends
      "kevinywlui/zlong_alert.zsh"
      # "chisui/zsh-nix-shell" # use zsh when running `$ nix-shell`
      "lukechilds/zsh-nvm"
    ];
  };

  programs.zsh = {
    enable = true;
    # initExtra = "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh";
    initExtra = ''
      #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
      export SDKMAN_DIR="$HOME/.sdkman"
      [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
    '';

    shellAliases = {
      up = "home-manager switch";
      t = "(wezterm start --cwd $PWD) &> /dev/null &";
      ap = ''readlink -e "$1"'';
      sbtn = ''sbt --client "$@"'';
      list-sbt = ''jps | grep sbt-launch.jar | cut -f 1 -d " " | xargs pwdx'';
      yay-unused = "yay -Rns $(yay -Qtdq)";
      jpsk = ''
        jps -l | awk '{
            # run pwdx for the first column, write the output to `wd`
            cmd = "pwdx "$1
            cmd | getline wd
            close(cmd)
            # pwdx prefixes the working directory with the pid, like "1234: /home/john", we remove it (modifying `wd` in-place)
            sub("[0-9]+: ", "", wd)
            # then append wd to the jps output
            print $0  " [" wd "]"
        }' | fzf --reverse -m -e -i | cut -d " " -f1 | xargs kill 2>/dev/null
      '';
      tpx = "terraform plan -out x";
      tax = "terraform apply x";
      tfmt = "terraform fmt -recursive";
      tss = "terraform state show";
      tsl = "terraform state list | grep";
      ti = "terraform import";
    };
  };

  programs.oh-my-posh.enable = true;
  programs.zoxide.enable = true;
  programs.carapace.enable = true;

}

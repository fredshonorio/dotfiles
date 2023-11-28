{ config, pkgs, lib, ... }:

let
  autostart = apps:
    let
      # { name: str, exec: str } -> { <path>: { source: file? } }
      autostartEntry = args: {
        ".config/autostart/${args.name}.desktop".text = ''
          [Desktop Entry]
          Name=${args.name}
          Exec=${args.exec}
          Terminal=false
          Type=Application
        '';
      };
    in lib.attrsets.mergeAttrsList (map autostartEntry apps);

  app = name: exec: {
    name = name;
    exec = exec;
  };

in {
  home.username = "fred";
  home.homeDirectory = "/home/fred";
  home.stateVersion = "23.05";

  home.packages = [
    pkgs.direnv
    pkgs.fzf
    pkgs.nixfmt
    pkgs.gum
    pkgs.entr
    pkgs.du-dust
    pkgs.procs
    pkgs.tealdeer
    pkgs.lsd
    pkgs.coursier
    pkgs.helix
    pkgs.metals

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

  home.file = lib.attrsets.mergeAttrsList [
    {
      ".direnvrc".source = files/direnvrc;
      ".gitconfig".source = files/gitconfig;
      ".terraformrc".source = files/terraformrc;
      ".terraform.d/plugin-cache/.keep".source = builtins.toFile "f" "";
      ".xbindkeysrc".source = files/xbindkeysrc;
      ".xmonad/xmonad.hs".source = files/xmonad.hs;
      ".p10k.zsh".source = files/.p10k.zsh;

      ".config/rofi/config.rasi".source = files/rofi-config.rasi;
      ".config/wezterm/wezterm.lua".source = files/wezterm/wezterm.lua;
      ".bin/c-ps".source = files/bin/c-ps;
      ".bin/git-branch-delete-fzf.zsh".source =
        files/bin/git-branch-delete-fzf.zsh;
      ".bin/flx".source = files/bin/flx;

      # navi
      # https://github.com/denisidoro/navi/blob/master/docs/cheatsheet_syntax.md
      ".bin/cheats/".source = files/bin/cheats;

      # polybar
      ".config/polybar/config.ini".source = files/polybar/config.ini;
      ".bin/polybar.sh".source = files/polybar/polybar.sh;

      ".bin/mgitstatus".source = pkgs.fetchFromGitHub {
        owner = "fboender";
        repo = "multi-git-status";
        rev = "2.2";
        sha256 = "jzoX7Efq9+1UdXQdhLRqBlhU3cBrk5AZblg9AYetItg=";
      } + "/mgitstatus";
    }
    (autostart [
      (app "discord" "/usr/bin/discord")
      (app "obsidian" "/usr/bin/obsidian")
      (app "signal" "/usr/bin/signal-desktop")
      (app "thunderbird" "/usr/bin/thunderbird")
      (app "xbindkeys" "/usr/bin/xbindkeys")
      (app "xmonad" "/usr/bin/xmonad --replace")
      (app "workrave" "/usr/bin/workrave")
    ])
  ];

  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
    FZF_CTRL_T_OPTS = "--preview 'bat --color=always --line-range :50 {}'";
    LC_ALL =
      "C.UTF-8"; # https://github.com/nix-community/home-manager/issues/3711
  };

  home.sessionPath = [ "$HOME/.bin" ];

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";

    initExtraFirst = ''
      export NVM_LAZY_LOAD=true
    '';

    initExtra = ''
      if [[ -r "''${XDG_CACHE_HOME:-''$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-''$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
      source ~/.p10k.zsh
      #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
      export SDKMAN_DIR="$HOME/.sdkman"
      [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
      bindkey "^[[H"  beginning-of-line # home key
      bindkey "^[[F"  end-of-line       # end key
      bindkey "^[[3~" delete-char       # delete key
    '';

    antidote = {
      enable = true;
      plugins = [
        "romkatv/powerlevel10k"
        # "robbyrussell/oh-my-zsh path:plugins/pipenv" TODO
        "zsh-users/zsh-autosuggestions" # suggest a matching previous command as you type
        "zsh-users/zsh-syntax-highlighting" # syntax highlighting on the prompt
        "ptavares/zsh-direnv" # direnv hooks for zsh (probably could be a program.)
        # add hooks into zsh so that it shows a notification when a long running (15 seconds) process ends
        "kevinywlui/zlong_alert.zsh"
        # "chisui/zsh-nix-shell" # use zsh when running `$ nix-shell`
        "lukechilds/zsh-nvm"
      ];
    };

    shellAliases = {
      up = "home-manager -f $HOME/.config/home-manager/host-$HOST.nix switch";
      ".." = "cd ./..";
      t = "(wezterm start --cwd $PWD) &> /dev/null &";
      ap = ''readlink -e "$1"'';
      v = "hx";
      # ls
      ls = "lsd";
      l = "lsd -lFh";
      la = "lsd -lAFh";
      ll = "lsd -l";
      lt = "lsd -lrtFh";
      lat = "lsd -lratFh";
      # jvm
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
      # terraform
      tpx = "terraform plan -out x";
      tax = "terraform apply x";
      tfmt = "terraform fmt -recursive";
      tss = "terraform state show";
      tsl = "terraform state list | grep";
      ti = "terraform import";
    };
  };

  # programs.oh-my-posh.enable = true;
  # programs.oh-my-posh.useTheme = "emodipt-extend";
  programs.oh-my-posh.settings = builtins.fromJSON
    (builtins.unsafeDiscardStringContext
      (builtins.readFile files/emodipt-extend-fred.omp.json));

  programs.zoxide.enable = true;

  # override Ctrl+R to use fzf
  # alt+c - list directories in pwd then cd into selected one
  # ctrl+t - search current directory and insert the selected file path in the prompt
  programs.fzf.enable = true;
  programs.carapace.enable = true;

  programs.navi.enable = true;
  programs.navi.settings = { cheats = { paths = [ "~/.bin/cheats" ]; }; };
}

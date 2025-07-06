{ lib, ... }:

{
  autostart = apps:
    let
      # { name: str, exec: str } -> { <path>: { source: file? } }
      autostartEntry = arg: {
        ".config/autostart/${builtins.elemAt arg 0}.desktop".text = ''
          [Desktop Entry]
          Name=${builtins.elemAt arg 0}
          Exec=${builtins.elemAt arg 1}
          Terminal=false
          Type=Application
        '';
      };
    in lib.attrsets.mergeAttrsList (map autostartEntry apps);

  app = name: exec: {
    name = name;
    exec = exec;
  };
}


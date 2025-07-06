{ lib, ... }:

{
  autostart = apps: # apps: { <app-name>: <app-bin-path>, ... }
    let
      # { name: str, exec: str } -> { <path>: { source: file? } }
      autostartEntry = name: exec: {
        ".config/autostart/${name}.desktop".text = ''
          [Desktop Entry]
          Name=${name}
          Exec=${exec}
          Terminal=false
          Type=Application
        '';
      };
    in lib.attrsets.concatMapAttrs autostartEntry apps;

}


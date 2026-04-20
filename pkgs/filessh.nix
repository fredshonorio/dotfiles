{
  pkgs,
  ...
}:

pkgs.rustPlatform.buildRustPackage {
  pname = "filessh";
  version = "0.4.2";

  src = pkgs.fetchFromGitHub {
    owner = "JayanAXHF";
    repo = "filessh";
    rev = "v0.4.2";
    hash = "sha256-50CI6pFmvYDpbAj1yrS6bhY1ZThOgM3S+pmT5u9TGUU=";
  };

  cargoHash = "sha256-uFsJSFPan9nL3VFg0MSI5qd9oylOv1As6wmOBoc0yUc=";

  meta = {
    description = "A fast and convenient TUI file browser for remote servers";
    homepage = "https://github.com/JayanAXHF/filessh";
    license = with pkgs.lib.licenses; [ unlicense mit ];
    mainProgram = "filessh";
  };
}

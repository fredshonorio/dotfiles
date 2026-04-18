{ pkgs }:
let
  version = "0.1.0-M7";
  platformMeta = {
    x86_64-linux = {
      archive = "cellar-${version}-linux-x86_64.tar.gz";
      hash = "sha256-iQaZxMeE7Iu5vhaOFtOOZ5MCRBrE0O/DjtZUT6L6NpQ=";
    };
    aarch64-linux = {
      archive = "cellar-${version}-linux-aarch64.tar.gz";
      hash = "sha256-XabTzGAnQOdxIW9GxkCmi/CMT/KQE9ZEV67HAMqGmmc=";
    };
  }.${pkgs.system};
in
pkgs.stdenv.mkDerivation {
  pname = "cellar";
  inherit version;
  src = pkgs.fetchurl {
    url = "https://github.com/VirtusLab/cellar/releases/download/v${version}/${platformMeta.archive}";
    hash = platformMeta.hash;
  };
  sourceRoot = ".";
  nativeBuildInputs = [
    pkgs.autoPatchelfHook
    pkgs.glibc
    pkgs.zlib
  ];
  unpackPhase = "tar xzf $src";
  installPhase = ''
    mkdir -p $out/bin
    cp cellar $out/bin/cellar
    chmod +x $out/bin/cellar
  '';
}

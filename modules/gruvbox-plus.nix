{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "gruvbox-plus";

  src = pkgs.fetchurl {
    url = "";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out
    ${pkgs.unzip}/bin/unzip $src -d $out/
  '';
}
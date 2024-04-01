{ pkgs }:
pkgs.stdenv.mkDerivation {
  name = "sddm-sugar-dark";

  src = pkgs.fetchFromGitHub {
    owner = "MarianArlt";
    repo = "sddm-sugar-dark";
    rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
    sha256 = pkgs.lib.fakeSha256;
  };

  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
    cd $out/
  '';
}
{ pkgs }:
let
  imgLink = "https://64.media.tumblr.com/16958cb609849796becc3ce87d321228/8adc7574e99f1e43-e6/s1280x1920/6153745aed37443a760e04689d4a8561a3a76354.jpg";

  image = pkgs.fetchUrl {
    url = imgLink;
    sha256 = pkgs.lib.fakeSha256;
  };
in
pkgs.stdenv.mkDerivation {
  name = "sddm-sugar-dark";

  src = pkgs.fetchFromGitHub {
    owner = "MarianArlt";
    repo = "sddm-sugar-dark";
    rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
    sha256 = "sha256-flOspjpYezPvGZ6b4R/Mr18N7N3JdytCSwwu6mf4owQ=";
  };

  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
    cd $out/
    rm Background.jpg
    cp -r ${image} $out/Background.jpg
  '';
}
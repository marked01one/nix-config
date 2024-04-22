{
  pkgs,
  runCommand,
  ...
}: let
  CURRENT_DIR = builtins.getEnv("PWD");
  
  image1 = {
    package = pkgs.fetchurl {
      url = "https://64.media.tumblr.com/bb4b758d23cb95284b06e5a983117078/45258116fed08252-a2/s2048x3072/45a8aefc450bacda2fad1b64ce02461c3b80b7d3.jpg";
      sha256 = "sha256-0ldhCZGRRQoeMbDp3y7X3UGTYpnDc6ToEBnq4ydeL/M=";
    };
    cropped = true;
  };

  config-dir = ./theme.conf;

  
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
      rm theme.conf
      cp -r ${image1.package} $out/Background.jpg
      cp -r ${config-dir} $out/theme.conf
    '';
  }

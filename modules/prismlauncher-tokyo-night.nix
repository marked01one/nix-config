{pkgs}: let
  user = "marked01one";
in
  pkgs.stdenv.mkDerivation {
    name = "prismlauncher-tokyo-night";

    src = pkgs.fetchurl {
      url = "https://github.com/PrismLauncher/Themes/releases/latest/download/Tokyo-Night-theme.zip";
      sha256 = "DaDoYVMV4cNLXcRgsTb3u1yeMlToON5Byibr0o/2rzU=";
    };

    dontUnpack = true;

    installPhase = ''
      ${pkgs.unzip}/bin/unzip $src -d /home/${user}/.local/share/PrismLauncher/themes/
    '';
  }

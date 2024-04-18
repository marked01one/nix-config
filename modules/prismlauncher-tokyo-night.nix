{pkgs}: let
  user = "marked01one";
in
  pkgs.stdenv.mkDerivation {
    name = "prismlauncher-tokyo-night";

    src = pkgs.fetchurl {
      url = "https://github.com/PrismLauncher/Themes/releases/latest/download/Tokyo-Night-theme.zip";
      sha256 = pkgs.lib.fakeSha256;
    };

    installPhase = ''
      mkdir /home/${user}/.local/share/PrismLauncher/themes
      ${pkgs.unizp}/bin/unzip $src -d /home/${user}/.local/share/PrismLauncher/themes/
    '';
  }

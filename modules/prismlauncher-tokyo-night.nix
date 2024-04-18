{pkgs}:
pkgs.stdenv.mkDerivation {
  name = "prismlauncher-tokyo-night";

  src = pkgs.fetchurl {
    url = "https://github.com/PrismLauncher/Themes/releases/latest/download/Tokyo-Night-theme.zip";
    sha256 = "DaDoYVMV4cNLXcRgsTb3u1yeMlToON5Byibr0o/2rzU=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out
    ${pkgs.unzip}/bin/unzip $src -d $out
  '';
}

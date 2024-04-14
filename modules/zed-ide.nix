{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "zed-ide";

  src = pkgs.fetchFromGitHub {
    owner = "zed-industries";
    repo = "zed";
  };

  buildInputs = with pkgs; [
    alsa-lib
    fontconfig
    libgcc
    libxkbcommon
    openssl_3_2
    rustup
    vulkan-loader
    zstd
  ];
}
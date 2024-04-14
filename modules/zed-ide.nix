{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "zed-ide";

  src = pkgs.fetchFromGitHub {
    owner = "zed-industries";
    repo = "zed";
    rev = "3289188e0adaa6c6e73836f8beef5abad3982376";
    sha256 = "7xJ/RGLtVF+crdZYcuEJxob2z6+znQNqzc1QeczNoqo=";
  };

  buildInputs = with pkgs; [
    alsa-lib
    fontconfig
    git
    libgcc
    libxkbcommon
    openssl_3_2
    rustup
    vulkan-loader
    zstd
  ];

  buildPhase = ''
    git submodule update --init --recursive
    cargo run --release
  '';
}
{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "zed-ide";

  src = fetchGit {
    url = "https://github.com/zed-industries/zed.git";
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
    mkdir -p $out
    cp -R ./*
    cd $out
    git submodule update --init --recursive
    cargo run --release
  '';
}
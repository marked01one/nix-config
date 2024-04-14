{ pkgs, lib, rustPlatform, ... }:

rustPlatform.buildRustPackage rec {
  name = "zed-ide";

  src = fetchGit {
    url = "https://github.com/zed-industries/zed.git";
    narHash = "sha256-7xJ/RGLtVF+crdZYcuEJxob2z6+znQNqzc1QeczNoqo=";
  };

  cargoSha256 = "7xJ/RGLtVF+crdZYcuEJxob2z6+znQNqzc1QeczNoqo=";

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
    cp --recursive ./* $out/
    cd $out
    cargo run --release
  '';
}
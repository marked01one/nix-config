{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "zed-ide";

  src = fetchGit {
    url = "https://github.com/zed-industries/zed.git";
    narHash = "sha256-7xJ/RGLtVF+crdZYcuEJxob2z6+znQNqzc1QeczNoqo=";
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
    cp --recursive ./* $out/
    cp .gitconfig $out/
    cd $out
    git config --global init.defaultBranch main
    git init
    git submodule update --init --recursive
    cargo run --release
  '';
}
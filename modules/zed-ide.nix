{ pkgs, # lib 
}:

pkgs.rustPlatform.buildRustPackage {
  name = "zed-ide";
  
  src = pkgs.fetchFromGitHub {
    owner = "zed-industries";
    repo = "zed";
    rev = "v0.130.6";
    sha256 = "HvzHqNfXoivsCegzoMMUW8avujq9OXqU+o8aU/f3d/g=";
  };  

  cargoSha256 = "HvzHqNfXoivsCegzoMMUW8avujq9OXqU+o8aU/f3d/g=";

  buildInputs = with pkgs; [
    alsa-lib
    fontconfig
    git
    libgcc
    libxkbcommon
    openssl
    rustup
    vulkan-loader
    zstd
  ];


  # meta = with lib; {
  #   description = "A high-performance, multiplayer code editor from the creators of Atom and Tree-sitter.";
  #   homepage = "https://zed.dev/";
  #   license = licenses.gpl3;
  # };
}
{
  # config,
  inputs,
  pkgs,
  ...
}: let
  homeImports = [
    ./home/hyprland.nix
    ./home/vscode.nix
    ./home/kitty.nix
    ./home/ags/ags.nix
  ];

  inputImports = [
    inputs.ags.homeManagerModules.default
  ];
in {
  nixpkgs.config.allowUnfree = true;

  imports = homeImports ++ inputImports;

  home.username = "khoi";
  home.homeDirectory = "/home/khoi";

  home.stateVersion = "24.05";
  home.packages = [
  ];

  # home.file = {
  #   ".config/neofetch/config.conf".text = ''${builtins.readFile ./conf/neofetch.conf}'';
  # };

  gtk = {
    enable = true;

    font = {
      name = "TeX Gyre Adventor";
      size = 12.0;
    };

    theme = {
      name = "Catpuccin-Mocha-Standard-Lavender-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = ["lavender"];
        size = "standard";
        tweaks = ["rimless" "black"];
        variant = "mocha";
      };
    };
  };

  qt = {
    enable = true;
  };

  programs = {
    home-manager.enable = true;
  };
}

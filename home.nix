{
  config,
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
      name = "Catppuccin-Mocha-Standard-Lavender-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = ["lavender"];
        size = "standard";
        tweaks = ["black"];
        variant = "mocha";
      };
    };
  };

  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  qt = {
    enable = true;
  };

  programs = {
    home-manager.enable = true;
  };
}

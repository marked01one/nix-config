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
    inputs.nix-colors.homeManagerModules.default
  ];

  desktopThemes = {
    catpuccin-lavender = {
      name = "Catppuccin-Mocha-Standard-Lavender-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = ["lavender"];
        tweaks = [ "normal" ];
        size = "compact";
        variant = "macchiato";
      };
    };

    nordic-darker = {
      name = "Nordic-darker";
      package = pkgs.nordic;
    };

    tokyonight = {
      name = "tokyonight-gtk-theme";
      package = pkgs.tokyonight-gtk-theme;
    };
  };

  gtkConfig = {
    gtk-application-prefer-dark-theme = "1";
  };
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
  
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };


  gtk = {
    enable = true;

    font = {
      name = "TeX Gyre Adventor";
      size = 12.0;
    };

    theme = desktopThemes.tokyonight;

    gtk3.extraConfig = gtkConfig;
    gtk4.extraConfig = gtkConfig; 
  };

  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  programs = {
    home-manager.enable = true;
  };
}

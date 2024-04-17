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
    ./home/waypaper.nix
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

    dracula = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };

    nightfox = {
      name = "Nightfox-Dusk-B";
      package = pkgs.nightfox-gtk-theme;
    };

    tokyonight = {
      name = "Tokyonight-Dark-B";
      package = pkgs.tokyonight-gtk-theme;
    };

    rose-pine = {
      name = "rose-pine-moon";
      package = pkgs.rose-pine-gtk-theme;
    };
  };

  gtkConfig = {
    gtk-application-prefer-dark-theme = "1";
  };
in {
  nixpkgs.config.allowUnfree = true;

  imports = homeImports ++ inputImports;

  home.username = "marked01one";
  home.homeDirectory = "/home/marked01one";

  home.stateVersion = "24.05";
  home.packages = [
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "brave";
    TERMINAL = "kitty";
  };

  # home.file = {
  #   ".config/neofetch/config.conf".text = ''${builtins.readFile ./conf/neofetch.conf}'';
  # };
  
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };


  colorScheme = inputs.nix-colors.colorSchemes.nord;

  xdg.desktopEntries = {
    obsidian = {
      name = "Obsidian";
      exec = "obsidian --disable-gpu";
      icon = "obsidian";
    };

    discord = {
      name = "Discord";
      exec = "discord --disable-gpu";
      icon = "discord";
    };

  };

  gtk = {
    enable = true;

    font = {
      name = "TeX Gyre Adventor";
      size = 12.0;
    };

    theme = desktopThemes.tokyonight;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "graphite-dark-nord";
      package = pkgs.graphite-cursors;
    };

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

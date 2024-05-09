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
    ./home/wallpapers.nix
    ./home/neovim/neovim.nix
    ./home/prismlauncher.nix
    ./home/zoxide.nix
    ./home/zsh.nix
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
        tweaks = ["normal"];
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

  home.packages = [
  ];

  home = {
    stateVersion = "24.05";
    username = "marked01one";
    homeDirectory = "/home/marked01one";
    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "brave";
      TERMINAL = "kitty";
    };
    # file = {
    #   ".zshrc".source = ./home/conf/.zshrc;
    # }; 
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  colorScheme = inputs.nix-colors.colorSchemes.tokyo-night-dark;

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

    neovim = {
      name = "Neovim wrapper";
      noDisplay = true;
    };

    nvim = {
      name = "Neovim";
      exec = "kitty -e nvim";
      icon = "nvim";
    };

    btop = {
      name = "btop++";
      exec = "kitty -e btop";
      icon = "btop";
    };

    xterm = {
      name = "XTerm";
      noDisplay = true;
    };

    nixos-manual = {
      name = "NixOS Manual";
      noDisplay = true;
    };

    nvtop = {
      name = "nvtop";
      exec = "kitty -e nvtop";
      icon = "nvtop";
    };

    lf = {
      name = "lf";
      exec = "kitty -e lf";
      icon = "terminal";
    };

    teams-for-linux = {
      name = "Microsoft Teams for Linux";
      exec = "teams-for-linux";
      icon = "teams-for-linux";
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
    platformTheme.name = "adwaita";
    style = desktopThemes.tokyonight;
  };

  programs = {
    home-manager.enable = true;
  };
}

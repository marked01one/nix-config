{ pkgs, ... }:

{
  programs.ags = {
    enable = true;

    configDir = .config/ags;

    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };

  home.file = {
    ".config/ags/config.js".source = ./config.js;
    ".config/ags/components" = {
      source = ./components;
      recursive = true;
    };
  }; 
}
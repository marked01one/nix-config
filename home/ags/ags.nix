{pkgs, ...}: {
  programs.ags = {
    enable = true;

    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };

  home.file = {
    ".config/ags/config.js".source = ./config.js;
    ".config/ags/tsconfig.json".source = ./tsconfig.json;
    ".config/ags/components" = {
      source = ./components;
      recursive = true;
    };
  };
}

{pkgs, ...}: {
  programs.ags = {
    enable = false;

    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };

  home.file = {
    ".config/ags/config.js".source = ./config.js;
    ".config/ags/styles.css".source = ./styles.css;
    ".config/ags/tsconfig.json".source = ./tsconfig.json;
    ".config/ags/components" = {
      source = ./components;
      recursive = true;
    };
  };
}

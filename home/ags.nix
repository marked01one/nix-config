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
    ".config/ags/config.js".source = ./../config/ags/config.js;
    ".config/ags/tsconfig.json".source = ./../config/ags/tsconfig.json;
    ".config/ags/components" = {
      source = ./../config/ags/components;
      recursive = true;
    };
    ".config/ags/styles" = {
      source = ./../config/ags/styles;
      recursive = true;
    };
  };
}

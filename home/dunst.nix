{pkgs, ...}: {
  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
      size = "32x32";
    };
  };
}
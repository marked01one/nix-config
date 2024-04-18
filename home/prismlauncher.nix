{pkgs, ...}: {
  home.file.".local/share/PrismLauncher/themes/Tokyo-Night-theme" = {
    source = "${import ./../modules/prismlauncher-tokyo-night.nix {inherit pkgs;}}";
    recursive = true;
  };
}

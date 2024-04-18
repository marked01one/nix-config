{pkgs, ...}: {
  home.file.".local/share/PrismLauncher" = {
    source = "${import ./../modules/prismlauncher-tokyo-night.nix {inherit pkgs;}}";
    recursive = true;
  };
}

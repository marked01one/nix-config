{pkgs, ...}: {
  imports = [
    (import ./../modules/prismlauncher-tokyo-night.nix {inherit pkgs;})
  ];
}

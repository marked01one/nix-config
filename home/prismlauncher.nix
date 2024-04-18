{pkgs, ...}:

{
  home.packages = [
    (import ./../modules/prismlauncher-tokyo-night.nix {inherit pkgs; })
  ];
}
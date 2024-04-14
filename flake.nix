{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags.url = "github:Aylur/ags";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs = {
    self,
    nixpkgs,
    hyprland,
    home-manager,
    nix-flatpak,
    ...
  } @ attrs: {
    #  config entry
    # Refresh using: `sudo -rebuild --flake .#hostname`
    nixosConfigurations = {
      perfect-linux = nixpkgs.lib.nixosSystem {
        specialArgs = attrs;
        system = "x86_64-linux";
        modules = [
          nix-flatpak.nixosModules.nix-flatpak
          ./configuration.nix
        ];

      };
    };

    homeConfigurations = {
      "khoi@perfect-linux" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [./home.nix];
      };
    };
  };
}
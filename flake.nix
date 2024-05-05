{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags.url = "github:Aylur/ags";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = {
    self,
    nixpkgs,
    hyprland,
    home-manager,
    nix-flatpak,
    nix-colors,
    ...
  } @ inputs: {
    #  config entry
    # Refresh using: `sudo -rebuild --flake .#hostname`
    nixosConfigurations = {
      perfect-linux = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit nixpkgs;
        };
        system = "x86_64-linux";
        modules = [
          nix-flatpak.nixosModules.nix-flatpak
          ./configuration.nix
        ];
      };
    };

    homeConfigurations = {
      "marked01one@perfect-linux" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [./home.nix];
      };
    };
  };
}

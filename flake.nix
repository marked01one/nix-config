{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-colors.url = "github:misterio77/nix-colors";
    ags.url = "github:Aylur/ags";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-flatpak,
    nix-colors,
    ags,
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
        extraSpecialArgs = { inherit inputs; };
        modules = [./home.nix];
      };
    };
  };
}

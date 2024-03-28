{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    home-manager = {
      url = "github:nix-community/home-manager" ;
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { 
    self, 
    nixpkgs,
    hyprland,
    home-manager, 
    ... 
  } @ inputs: {
    # NixOS config entry
    # Refresh using: `sudo nixos-rebuild --flake .#hostname`
    nixosConfigurations = {
      perfect-linux = nixpkgs.lib.nixosSystem {
        specialArgs = { 
          inherit inputs; 
        };
        system = "x86_64-linux";
        modules = [./nixos/configuration.nix];
      };
    };

    homeConfigurations = {
      "khoi@perfect-linux" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux"; 
        modules = [ ./nixos/home.nix ];
      };
    };
  };
}

{ 
 # config, 
 inputs,
 pkgs, 
  ... 
}: let
  homeImports = [
    ./home/hyprland.nix
    ./home/vscode.nix
    ./home/kitty.nix
    ./home/ags/ags.nix
  ];

in {
  nixpkgs.config.allowUnfree = true;

  imports = homeImports;

  
  home.username = "khoi";
  home.homeDirectory = "/home/khoi";

  home.stateVersion = "24.05"; 
  home.packages = [
    
  ];



  # home.file = {
  #   ".config/neofetch/config.conf".text = ''${builtins.readFile ./conf/neofetch.conf}''; 
  # };

  gtk = {
    enable = true;
  };

  qt = {
    enable = true;
  };

  programs = {
    home-manager.enable = true;
  };
}

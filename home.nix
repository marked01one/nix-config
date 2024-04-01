{ 
 # config, 
 pkgs, 
  ... 
}: let
  homeImports = [
    ./home/hyprland.nix
  
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

  programs.home-manager.enable = true;

}

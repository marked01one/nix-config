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
  ];

  inputImports = [
    inputs.ags.homeManagerModules.default
  ];

in {
  nixpkgs.config.allowUnfree = true;

  imports = homeImports ++ inputImports;

  
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

    ags = {
      enable = true;

      extraPackages = with pkgs; [
        gtksourceview
        webkitgtk
        accountsservice
      ];
    };
  };
}

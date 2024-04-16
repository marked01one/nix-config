{pkgs, ...}: let
  luminousslime_001 = pkgs.fetchurl {
    url = "https://64.media.tumblr.com/8951f93faf3d679cdea3409e592eb078/8c2ca60ecb11ec25-4d/s2048x3072/1723bbadfbc4ec9e0293a16cda091e12e58f72a0.jpg";
    sha256 = "oxRYFd/WArFYSTvz7hbL0XiapuUhaTZ+OOqQe9MKqU4="; 
  };
in {
  home.file = {
    "Pictures/Wallpapers/luminousslime_001.jpg".source = luminousslime_001;
    
    ".config/waypaper/config.ini".text = ''
      [Settings]
      language = en
      folder = ~/Pictures/Wallpapers
      wallpaper = ~/Pictures/Wallpapers/luminousslime_001.jpg
      backend = swww
      monitors = All
      fill = Fill
      sort = name
      subfolders = True
    '';
  };
}
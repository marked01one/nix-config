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
      folder = /home/marked01one/Pictures/Wallpapers
      wallpaper = /home/marked01one/Pictures/Wallpapers/luminousslime_001.jpg
      backend = swww
      monitors = All
      fill = Fill
      sort = name
      color = #ffffff
      subfolders = False
      post_command =
      swww_transition_type = any
      swww_transition_step = 90
      swww_transition_angle = 0
      swww_transition_duration = 2
    '';
  };
}

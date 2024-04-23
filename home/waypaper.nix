{pkgs, ...}:
{
  home.file = {
    "Pictures/Wallpapers/1.jpg".source = pkgs.fetchurl {
      url = "https://64.media.tumblr.com/8951f93faf3d679cdea3409e592eb078/8c2ca60ecb11ec25-4d/s2048x3072/1723bbadfbc4ec9e0293a16cda091e12e58f72a0.jpg";
      sha256 = "oxRYFd/WArFYSTvz7hbL0XiapuUhaTZ+OOqQe9MKqU4=";
    };

    "Pictures/Wallpapers/2.jpg".source = pkgs.fetchurl {
      url = "https://64.media.tumblr.com/bb4b758d23cb95284b06e5a983117078/45258116fed08252-a2/s2048x3072/45a8aefc450bacda2fad1b64ce02461c3b80b7d3.jpg";
      sha256 = "0ldhCZGRRQoeMbDp3y7X3UGTYpnDc6ToEBnq4ydeL/M=";
    };

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

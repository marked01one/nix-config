{pkgs, ...}: {
  home.file = {
    "Pictures/Wallpapers/1.jpg".source = pkgs.fetchurl {
      url = "https://64.media.tumblr.com/8951f93faf3d679cdea3409e592eb078/8c2ca60ecb11ec25-4d/s2048x3072/1723bbadfbc4ec9e0293a16cda091e12e58f72a0.jpg";
      sha256 = "oxRYFd/WArFYSTvz7hbL0XiapuUhaTZ+OOqQe9MKqU4=";
    };

    "Pictures/Wallpapers/2.jpg".source = pkgs.fetchurl {
      url = "https://64.media.tumblr.com/bb4b758d23cb95284b06e5a983117078/45258116fed08252-a2/s2048x3072/45a8aefc450bacda2fad1b64ce02461c3b80b7d3.jpg";
      sha256 = "0ldhCZGRRQoeMbDp3y7X3UGTYpnDc6ToEBnq4ydeL/M=";
    };

    "Picture/Wallpapers/3.jpg".source = pkgs.fetchurl {
      url = "https://64.media.tumblr.com/358b5f58ebaf68cc5c8145b36e2f2773/30ef98839f9be569-83/s2048x3072/28111406e017ff2dc0f61c3d0477ad4c05696d26.jpg";
      sha256 = pkgs.lib.fakeSha256;
    };
  };
}

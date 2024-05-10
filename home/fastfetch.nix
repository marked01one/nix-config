{pkgs,...}: {
  home.file = {
    ".config/fastfetch/config.jsonc".source = ./../config/fastfetch/fastfetch.jsonc;

    ".config/fastfetch/logo1.jpg".source = pkgs.fetchurl {
      url = "https://64.media.tumblr.com/16958cb609849796becc3ce87d321228/8adc7574e99f1e43-e6/s1280x1920/6153745aed37443a760e04689d4a8561a3a76354.jpg";
      sha256 = "CS/VngzYRpzZA3oVJUTcCvh7dhtXMx8Qvf/cpCYesLc=";
    };
  };
}
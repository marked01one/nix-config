{pkgs}: let
  img = theme3;

  theme1 = {
    package = pkgs.fetchurl {
      url = "https://64.media.tumblr.com/bb4b758d23cb95284b06e5a983117078/45258116fed08252-a2/s2048x3072/45a8aefc450bacda2fad1b64ce02461c3b80b7d3.jpg";
      sha256 = "sha256-0ldhCZGRRQoeMbDp3y7X3UGTYpnDc6ToEBnq4ydeL/M=";
    };
    isCropped = "true";
    format = "jpg";
    imagePosition = "center";
    blurType = "full";
  };

  theme2 = {
    package = pkgs.fetchurl {
      url = "https://64.media.tumblr.com/1fd9b495b00978fe65cbdcc3e3523542/a790fa0c69e4b99e-0b/s2048x3072/1d6bd9e0ad968bc5d45f4477cfd1543472e9574a.png";
      sha256 = "sha256-mnRvsO6jWGXlJTYodlJxZNC4U0SlJ6QcF7picqAhBuk=";
    };
    isCropped = "false";
    format = "png";
    imagePosition = "right";
    blurType = "partial";
    backgroundColor = "#FFF";
  };

  theme3 = {
    package = pkgs.fetchurl {
      url = "https://64.media.tumblr.com/16958cb609849796becc3ce87d321228/8adc7574e99f1e43-e6/s1280x1920/6153745aed37443a760e04689d4a8561a3a76354.jpg";
      sha256 = "sha256-CS/VngzYRpzZA3oVJUTcCvh7dhtXMx8Qvf/cpCYesLc=";
    };
    isCropped = "false";
    format = "png";
    imagePosition = "right";
    blurType = "none";
    backgroundColor = "#FFF";
  };
in
  pkgs.stdenv.mkDerivation {
    name = "sddm-sugar-candy";

    # src = pkgs.fetchFromGitHub {
    #   owner = "MarianArlt";
    #   repo = "sddm-sugar-dark";
    #   rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
    #   sha256 = "sha256-flOspjpYezPvGZ6b4R/Mr18N7N3JdytCSwwu6mf4owQ=";
    # };

    src = pkgs.fetchgit {
      url = "https://framagit.org/MarianArlt/sddm-sugar-candy.git";
      sha256 = "XggFVsEXLYklrfy1ElkIp9fkTw4wvXbyVkaVCZq4ZLU=";
    };

    theme = pkgs.writeText "theme.conf" ''
      [General]
      Background="Background.${img.format}"
      DimBackgroundImage="0.0"
      ScaleImageCropped="${img.isCropped}"
      ScreenWidth="2560"
      ScreenHeight="1600"

      ## [Blur Settings]
      FullBlur="${
        if img.blurType == "full"
        then "true"
        else "false"
      }"
      PartialBlur="${
        if img.blurType == "partial"
        then "true"
        else "false"
      }"
      BlurRadius="100"

      ## [Design Customizations]
      HaveFormBackground="false"
      FormPosition="${
        if img.imagePosition == "left"
        then "right"
        else "left"
      }"
      BackgroundImageHAlignment="${img.imagePosition}"
      BackgroundImageVAlignment="center"
      MainColor="black"
      AccentColor="#fb884f"
      BackgroundColor="#FFF"
      OverrideLoginButtonTextColor=""
      InterfaceShadowSize="6"
      InterfaceShadowOpacity="0.6"
      RoundCorners="20"
      ScreenPadding="0"
      Font="TeX Gyre Adventor"
      FontSize=""

      ## [Interface Behavior]
      ForceRightToLeft="false"
      ForceLastUser="true"
      ForcePasswordFocus="true"
      ForceHideCompletePassword="false"
      ForceHideVirtualKeyboardButton="false"
      ForceHideSystemButtons="false"
      AllowEmptyPassword="false"
      AllowBadUsernames="false"

      ## [Locale Settings]
      Locale=""
      HourFormat="HH:mm"
      DateFormat="dddd, d of MMMM"

      ## [Translations]
      HeaderText="Welcome!"
      TranslatePlaceholderUsername=""
      TranslatePlaceholderPassword=""
      TranslateShowPassword=""
      TranslateLogin=""
      TranslateLoginFailedWarning=""
      TranslateCapslockWarning=""
      TranslateSession=""
      TranslateSuspend=""
      TranslateHibernate=""
      TranslateReboot=""
      TranslateShutdown=""
      TranslateVirtualKeyboardButton=""
    '';

    installPhase = ''
      mkdir -p $out
      cp -R ./* $out/
      cd $out/
      rm theme.conf
      rm -r Backgrounds/
      cp -r ${img.package} $out/Background.${img.format}
      cp -r $theme $out/theme.conf
    '';
  }

{
  pkgs,
}: let
  image1 = {
    package = pkgs.fetchurl {
      url = "https://64.media.tumblr.com/bb4b758d23cb95284b06e5a983117078/45258116fed08252-a2/s2048x3072/45a8aefc450bacda2fad1b64ce02461c3b80b7d3.jpg";
      sha256 = "sha256-0ldhCZGRRQoeMbDp3y7X3UGTYpnDc6ToEBnq4ydeL/M=";
    };
    isCropped = "true";
    format = "jpg";
  };

  image2 = {
    package = pkgs.fetchurl {
      url = "https://64.media.tumblr.com/1fd9b495b00978fe65cbdcc3e3523542/a790fa0c69e4b99e-0b/s2048x3072/1d6bd9e0ad968bc5d45f4477cfd1543472e9574a.png";
      sha256 = "sha256-mnRvsO6jWGXlJTYodlJxZNC4U0SlJ6QcF7picqAhBuk="; 
    };
    isCropped = "false";
    format = "png";
  };

  img = image2;
in
  pkgs.stdenv.mkDerivation {
    name = "sddm-sugar-dark";

    src = pkgs.fetchFromGitHub {
      owner = "MarianArlt";
      repo = "sddm-sugar-dark";
      rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
      sha256 = "sha256-flOspjpYezPvGZ6b4R/Mr18N7N3JdytCSwwu6mf4owQ=";
    };

    theme = pkgs.writeText "theme.conf" ''
      [General]
      Background="Background.${img.format}"
      ScaleImageCropped=${img.isCropped}
      ScreenWidth=2560
      ScreenHeight=1600
      MainColor="navajowhite"
      AccentColor="white"
      RoundCorners=20
      ScreenPadding=0
      Font="Noto Sans"
      FontSize=
      Locale=
      HourFormat="HH:mm"
      DateFormat="dddd, d of MMMM"
    
      ForceLastUser=true
      ForcePasswordFocus=true
      ForceHideCompletePassword=false
      ForceHideVirtualKeyboardButton="false"
    
      TranslateUsernamePlaceholder=""
      TranslatePasswordPlaceholder=""
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
      rm Background.*
      rm theme.conf
      cp -r ${img.package} $out/Background.${img.format}
      cp -r $theme $out/theme.conf
    '';
  }

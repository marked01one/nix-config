{
  # config,
  lib,
  pkgs,
  ...
}: let
  mod = "Mod4";
in {
  xsession.windowManager.i3 = {
    enable = true;

    config = {
      modifier = mod;

      fonts = {
        names = ["CaskaydiaCove Nerd Font"];
        size = 12.0;
      };

      keybindings = lib.mkOptionDefault {
        "${mod}+Shift+Return" = "exec --no-startup-id brave";
      };

      bars = [
        {
          position = "bottom";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${./../config/i3/i3status-rust.toml}";
          fonts = {
            names = ["CaskaydiaCove Nerd Font"];
            size = 12.0;
          };
        }
      ];
    };
  };
}

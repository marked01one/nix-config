{ 
 # config, 
 # lib, 
 # pkgs, 
  ... 
}: let 
  MOD = "SUPER";
in {
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      # monitor = [
      #   "eDP-1,2560x1600@240,0x0,auto"
      #   "DP-3,2560x1440@240,2560x0,auto"
      #   "HDMI-A-3,2560x1440@120,2560x0,auto"
      # ];

      monitor = [ ",preferred,auto,auto" ];

      env = "XCURSOR_SIZE,20";
      
      exec-once = [
        "hyprctl setcursor "
        "waypaper --restore"
        "dbus-update-activcation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];

      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_rules = "";

        follow_mouse = 0;

        touchpad = {
          natural_scroll = false;
        };

        sensitivity = 0;
      };

      general = {
        gaps_in = 3;
        gaps_out = 6;
        border_size = 3;

        "col.active_border" = "0xffbf5a89 0xffd99cac 90deg";
        "col.inactive_border" = "0x00000000";

        layout = "dwindle";

        allow_tearing = false;
      };

      decoration = {
        rounding = 4;

        blur = {
          enabled = false;
          size = 4;
          passes = 1;
        };

        drop_shadow = false;
        shadow_range = 2;
        shadow_render_power = 4;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_is_master = true;
      };

      gestures = {
        workspace_swipe = true;
      };

      bind = [
        ",XF86MonBrightnessUp, exec, brightnessctl set +10%"
        ",XF86MonBrightnessDown, exec, brightnessctl set 10%-"

        "${MOD} SHIFT, P, exec, systemctl poweroff"
        "${MOD} SHIFT, RETURN, exec, brave"
        "${MOD}, SPACE, exec, rofi -show drun -show-icons"
        "${MOD}, RETURN, exec, kitty"
        
	      "${MOD} SHIFT, Q, killactive"

	      "${MOD} ALT, right, workspace, e+1"
        "${MOD} ALT, left, workspace, e-1"

        "${MOD} SHIFT, right, movetoworkspace, e+1"
        "${MOD} SHIFT, left, movetoworkspace, e-1"

        "${MOD}, S, togglespecialworkspace, magic"
        "${MOD} SHIFT, S, movetoworkspace, special:magic"
        "${MOD}, F, fullscreen, 1"

        "${MOD} SHIFT, right, movetoworkspace, e+1"
        "${MOD} SHIFT, left, movetoworkspace, e-1"

        # Move focus with $MOD + arrow keys
        "${MOD}, left, movefocus, l"
        "${MOD}, right, movefocus, r"
        "${MOD}, up, movefocus, u"
        "${MOD}, down, movefocus, d"
      ]
      ++ (
        builtins.concatLists(builtins.genList(
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString(x + 1 - (c * 10));
            in [
              "${MOD}, ${ws}, workspace, ${toString(x + 1)}"
              "${MOD} SHIFT, ${ws}, movetoworkspace, ${toString(x + 1)}"
            ]
          )
        10)
      );

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      xwayland = {
        force_zero_scaling = true;
      };
    };
  };
}

{
  # config,
  pkgs,
  lib,
  ...
}: {
  programs.kitty = {
    enable = true;

    font = {
      name = "CaskaydiaCove Nerd Font";
      size = 14.0;
    };

    theme = "Tokyo Night";

    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+v" = "paste_from_clipboard";

      "ctrl+shift+up" = "scroll_line_up";
      "ctrl+shift+k" = "scroll_line_up";
      "ctrl+shift+down" = "scroll_line_down";
      "ctrl+shift+j" = "scroll_line_down";
    };

    settings = {
      confirm_os_window_close = 0;
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = false;
      scan_timeout = 10;
      character = {
        success_symbol = "➜";
        error_symbol = "➜";
      };

      hostname = {
        disabled = false;
        format = "[$ssh_symbol](bold blue) on [$hostname](bold red) ";
      };

      username = {
        disabled = false;
        show_always = true;
        style_user = "white bold";
        style_root = "red bold";
        format = "[$user]($style) in ";
      };
    };
  };
}

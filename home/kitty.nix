{
  # config,
  pkgs,
  lib,
  ...
}:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "CaskaydiaCove Nerd Font";
      size = 10.0;
    };

    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+v" = "paste_from_clipboard";
      
      "ctrl+shift+up" = "scroll_line_up";
      "ctrl+shift+k" = "scroll_line_up";
      "ctrl+shift+down" = "scroll_line_down";
      "ctrl+shift+j" = "scroll_line_down";
    };

    settings = {

    };    
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = false;
      format = lib.concatStrings [
        "$username@$hostname ~ $directory"
        "$line_break"
        "$character"
      ];
      scan_timeout = 10;
      character = {
        success_symbol = "➜";
        error_symbol = "➜";
      };
    };
  };
}
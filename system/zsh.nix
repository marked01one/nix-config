{...}: {
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestions = {
      enable = true;
      async = true;
      strategy = ["history" "completion" "match_prev_cmd"];
    };
    syntaxHighlighting = {
      enable = true;
      styles = {
        "aliases" = "fg=magenta,bold";
      };
    };

    interactiveShellInit = ''
      eval "$(starship init zsh)"
      eval "$(zoxide init zsh)"
    '';

    shellAliases = {
      # Allow `sudo` to be used with aliases
      sudo = "sudo ";
      ls = "lsd -1";
      ll = "lsd -1 -a -l";
      c = "/run/current-system/sw/bin/code";

      cfnix = "/run/current-system/sw/bin/code ~/SystemFlake";
      update = "sudo nixos-rebuild switch --flake ~/SystemFlake/#perfect-linux";

      logout = "pkill -u $(whoami)";
      shutdown = "systemctl poweroff";
      "copy-pw" = "sudo cat ~/.token | xclip -sel clip";

      home = "cd ~";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
    };
  };
}

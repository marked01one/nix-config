{pkgs, ...}: {
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestions = {
      enable = true;
      async = true;
      strategy = "completion";
    };
    syntaxHighlighting = {
      enable = true;
      package = pkgs.zsh-syntax-highlighting; 
    };

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
      };
    

  };
}

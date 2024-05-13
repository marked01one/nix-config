{
  pkgs,
  # lib,
  ...
}: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions;
      [
        jnoortheen.nix-ide
        vscodevim.vim
        pkief.material-icon-theme
        equinusocio.vsc-material-theme
        enkia.tokyo-night
        golang.go
        sumneko.lua
        postman.postman-for-vscode
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "vscode-typescript-next";
          publisher = "ms-vscode";
          version = "5.5.20240411";
          sha256 = "gyQCiyt4WQ/lhIoIE5qRPnnaN73kJ1khCAZtRHTj1Vs=";
        }
      ];

    userSettings = {
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.serverSettings"."nil" = {
        formatting.command = ["alejandra"];
      };

      "editor.accessibilityPageSize" = 12;
      "window.titleBarStyle" = "custom";

      "editor.fontFamily" = "CaskaydiaCove Nerd Font";

      "workbench.colorTheme" = "Tokyo Night";
      "workbench.activityBar.location" = "top";
      "workbench.iconTheme" = "material-icon-theme";
      "editor.fontSize" = 16;
      "workbench.sideBar.location" = "right";

      "redhat.telemetry.enabled" = false;

      # "java.home" = "/run/current-system/sw/lib/openjdk";
    };
  };
}

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
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "vscode-typescript-next";
          publisher = "ms-vscode";
          version = "5.5.20240411";
          sha256 = "gyQCiyt4WQ/lhIoIE5qRPnnaN73kJ1khCAZtRHTj1Vs=";
        }
        {
          name = "postman-for-vscode";
          publisher = "postman";
          version = "1.0.1";
          sha256 = "38fwjQ32M4dv5UOf/4CWEkDOG00I1LbiSj+HAG/UVE0=";
        }
        {
          name = "csdevkit";
          publisher = "ms-dotnettools";
          version = "1.5.20";
          sha256 = pkgs.lib.fakeSha256;
        }
        {
          name = "csharp";
          publisher = "ms-dotnettools";
          version = "2.28.11";
          sha256 = pkgs.lib.fakeSha256;
        }
        {
          name = "vscodeintellicode-csharp";
          publisher = "ms-dotnettools";
          version = "2.1.11";
          sha256 = pkgs.lib.fakeSha256;
        }
        {
          name = "vscode-nuget-gallery";
          publisher = "patcx";
          version = "1.0.0";
          sha256 = "kymExeo3BsfjeNR8vFr0SVe7WefL7v4IunJYG6dKhoY=";
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

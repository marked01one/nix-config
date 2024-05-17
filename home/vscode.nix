{
  pkgs,
  # lib,
  ...
}: {
  programs.vscode = {
    enable = true;
    extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
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
          sha256 = pkgs.lib.fakeSha256;
        }
        {
          name = "csdevkit";
          publisher = "ms-dotnettools";
          version = "1.5.20";
          sha256 = "VsQKAgxbskRfmwZof8BNmguXtPzm55aKmYJu3guZdm4=";
        }
        {
          name = "csharp";
          publisher = "ms-dotnettools";
          version = "2.28.11";
          sha256 = "ZGzwWQcwXGgZ+oEKfTX2Dc62KerOmE0v34d7b00sei8=";
        }
        {
          name = "vscodeintellicode-csharp";
          publisher = "ms-dotnettools";
          version = "2.1.11";
          sha256 = "QOnaDLNpaVrSbXbbGYw1fE8BuWz2DyB6j6OpDW/95kE=";
        }
        {
          name = "vscode-nuget-gallery";
          publisher = "patcx";
          version = "1.0.0";
          sha256 = "kymExeo3BsfjeNR8vFr0SVe7WefL7v4IunJYG6dKhoY=";
        }
        {
          name = "vscode-dotnet-runtime";
          publisher = "ms-dotnettools";
          version = "2.0.5";
          sha256 = "LO1vF3WHsqqL4LbzcBohkU90bRB7wnXrhJxaVfCMcbE=";
        }
        {
          name = "go";
          publisher = "golang";
          version = "0.41.4";
          sha256 = "ntrEI/l+UjzqGJmtyfVf/+sZJstZy3fm/PSWKTd7/Q0=";
        }
        {
          name = "vim";
          publisher = "vscodevim";
          version = "1.27.2";
          sha256 = "O5G4yhvD2HvKb4Vbvr1v20nMEQq88f5RE+X50bZvr1Q=";
        }
        {
          name = "nix-ide";
          publisher = "jnoortheen";
          version = "0.3.1";
          sha256 = "05oMDHvFM/dTXB6T3rcDK3EiNG2T0tBN9Au9b+Bk7rI=";
        }
        {
          name = "lua";
          publisher = "sumneko";
          version = "3.9.1";
          sha256 = "oBhVzC6rMEzx8JjU2GepSCwRuHFnLqrhxNbRoakw2dk=";
        }
        {
          name = "tokyo-night";
          publisher = "enkia";
          version = "1.0.6";
          sha256 = "VWdUAU6SC7/dNDIOJmSGuIeffbwmcfeGhuSDmUE7Dig=";
        }
        {
          name = "material-icon-theme";
          publisher = "pkief";
          version = "5.3.0";
          sha256 = "SCiRpqoUy+TKkiOrhjL5dPvYCMlxnEaVUb0Cjiu3674=";
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

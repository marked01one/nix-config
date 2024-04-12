{ pkgs, lib, ... }:

{
    programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [ 
            jnoortheen.nix-ide
            vscodevim.vim
            pkief.material-icon-theme
            equinusocio.vsc-material-theme
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
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
                formatting.command = [ "alejandra" ];
            };

            "editor.accessibilityPageSize" = 11;
            "window.titleBarStyle" = "custom";

            "editor.fontFamily" = "CaskaydiaCove Nerd Font";

            "workbench.colorTheme" = "Material Theme Ocean High Contrast";
            "workbench.activityBar.location" = "top";
            "workbench.iconTheme" = "material-icon-theme";
        };
    };
}
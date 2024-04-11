{ pkgs, ... }:

{
    programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
            jnoortheen.nix-ide
            vscodevim.vim
            pkief.material-icon-theme
            equinusocio.vsc-material-theme
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
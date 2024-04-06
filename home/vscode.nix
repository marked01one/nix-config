{ pkgs, ... }:

{
    programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
            jnoortheen.nix-ide
            vscodevim.vim
        ];

        userSettings = {
            "nix.enableLanguageServer" = true;
            "nix.serverPath" = "nil";
            "nix.serverSettings"."nil" = {
                formatting.command = [ "alejandra" ];
            };

            "editor.fontFamily" = "CaskaydiaCove Nerd Font";
        };
    };
}
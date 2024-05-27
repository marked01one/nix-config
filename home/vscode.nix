{
  # pkgs,
  # lib,
  ...
}: {
  programs.vscode = {
    enable = true;

    userSettings = {
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.serverSettings"."nil" = {
        formatting.command = ["alejandra"];
      };

      "editor.accessibilityPageSize" = 12;
      "window.titleBarStyle" = "custom";

      "editor.fontFamily" = "CaskaydiaCove Nerd Font";

      "workbench.colorTheme" = "Material Theme Ocean High Contrast";
      "workbench.activityBar.location" = "top";
      "workbench.iconTheme" = "material-icon-theme";
      "editor.fontSize" = 16;
      "workbench.sideBar.location" = "right";

      "redhat.telemetry.enabled" = false;

      "update.mode" = "none";

      "[json]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };

      # "java.home" = "/run/current-system/sw/lib/openjdk";
    };
  };
}

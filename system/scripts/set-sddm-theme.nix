{pkgs}: let
  currentDir = builtins.getEnv("PWD");

in pkgs.writeShellScriptBin "set-sddm-theme" ''
  echo ${currentDir}
''

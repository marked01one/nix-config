{pkgs}:
pkgs.writeShellScriptBin "battery-startup-check" ''
  if [[ "$(supergfxctl -g)" = "Integrated" ]]; then
    brightnessctl 10%
  fi
''

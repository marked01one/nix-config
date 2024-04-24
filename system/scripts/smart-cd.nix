{pkgs}:
pkgs.writeShellScriptBin "smart-cd" ''
  zi $1 2> /dev/null
  if (( $1 > 0 )); then
    z $1
  fi
''
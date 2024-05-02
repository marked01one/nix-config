{pkgs}:
pkgs.writeShellScriptBin "smart-cd" ''
  eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"
  zi $1 2> /dev/null
  if (( $? > 0 )); then
    z $1
  fi
''
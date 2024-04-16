{pkgs}:

pkgs.writeShellScriptBin "check-pkg" ''
  RESULT=$(nix build nixpkgs#$1 --print-out-paths --no-link | cd)
  echo $RESULT
  if [ $exit_code == 0 ]; then
    nix run nixpkgs#lsd -- --tree --depth 4
  fi
''
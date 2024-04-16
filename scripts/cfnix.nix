{pkgs}:

pkgs.writeShellScriptBin "check-pkg" ''
  cd $(nix build nixpkgs#$1 --print-out-paths --no-link)
  exit_code=$?
  echo 'Exit Code: $1'
  if [ $exit_code == 0 ]; then
    nix run nixpkgs#lsd -- --tree --depth 4
  fi
''
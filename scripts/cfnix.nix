{pkgs}:
pkgs.writeShellScriptBin "check-pkg" ''
  cd "$(nix build nixpkgs#$1 --print-out-paths --no-link)"
  nix run nixpkgs#lsd -- --tree --depth 4
''

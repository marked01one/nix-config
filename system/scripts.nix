{pkgs}:

pkgs.writeShellScriptBin "check-pkg" ''${builtins.readFile(./scripts/check-pkg.sh)}''

pkgs.writeShellScriptBin "swww-init" ''${builtins.readFile(./scripts/swww-init.sh)}''

pkgs.writeShellScriptBin "nvidia-offload" ''${builtins.readFile(./scripts/nvidia-offload.sh)}''
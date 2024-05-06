function smart-cd() {
    zi $1 2> /dev/null
    if (( $? > 0 )); then
        z $1
    fi
}

function check-pkg() {
    cd "$(nix build nixpkgs#$1 --print-out-paths --no-link)"
    nix run nixpkgs#lsd -- --tree --depth 4
}

function nvidia-offload() {
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
}

# History

HISTSIZE="10000"
SAVEHIST="10000"

HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY

# Aliases

sudo="sudo ";
ls="lsd -1";
ll="lsd -1 -a -l";
c="/run/current-system/sw/bin/code";
cat="bat";

cfnix="/run/current-system/sw/bin/code ~/SystemFlake";
update="sudo nixos-rebuild switch --flake ~/SystemFlake/#perfect-linux";

logout="pkill -u $(whoami)";
shutdown="systemctl poweroff";

home="cd ~";
".."="cd ..";
"..."="cd ../..";

# Evaluate on startup

eval "$(zoxide init zsh)"

if [[ $TERM != "dumb" ]]; then
    eval "$(starship init zsh)"
fi

if test -n "$KITTY_INSTALLATION_DIR"; then
    export KITTY_SHELL_INTEGRATION="no-rc"
    autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
    kitty-integration
    unfunction kitty-integration
fi
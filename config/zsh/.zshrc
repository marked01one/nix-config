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

function cv() {
    exceptions=("~" "." ".." "...")
    if [[ "${exceptions[@]}" =~ "$1" ]]; then 
        cd $1
    elif eval "zi $1"; then
        return
    else
        eval "z $1"
        echo "Adding new directory '$PWD'...\n"
    fi
}

function update() {
    
}

function neofetch() {
    echo ""
    fastfetch --kitty "$HOME/.config/fastfetch/logo1.jpg" --logo-width 40 --logo-padding 2
    echo ""
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

alias sudo="sudo "
alias ls="lsd -1"
alias ll="lsd -1 -a -l"
alias c="/run/current-system/sw/bin/code"
alias cat="bat"
alias vim="nvim"

alias cfnix="/run/current-system/sw/bin/code ~/SystemFlake"
alias update="sudo nixos-rebuild switch --flake ~/SystemFlake/#perfect-linux"
alias go="GOTELEMETRY=off go"

alias logout="pkill -u $(whoami)"
alias shutdown="systemctl poweroff"

alias home="cd ~"
alias ".."="cd .."
alias "..."="cd ../.."

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
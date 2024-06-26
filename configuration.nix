# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  # config,
  pkgs,
  ...
}: let
  desktopApps = with pkgs; [
    neovim-unwrapped
    vscode-fhs
    grimblast
    space-cadet-pinball
    drawio
    discord
    betterdiscordctl
    prismlauncher
    networkmanagerapplet
    zathura
    teams-for-linux
    obsidian
    zotero
    qucs-s
    osu-lazer-bin
    qemu
    libreoffice
    blueman
    brave
    swayimg
    slack
    delta
    pandoc
    jan
    virtualbox
    heroic
  ];

  flatpakApps = ["app.moosync.moosync" "org.kicad.KiCad"];

  commandLineApps = with pkgs; [
    wget
    curl
    networkmanager
    lsd
    zoxide
    zsh-autocomplete
    zsh-autosuggestions
    fastfetch
    btop
    thefuck
    bat
    xclip
    lf
    fzf

    _2048-in-terminal
  ];

  languages = with pkgs; [
    rustc
    cargo
    go
    lua
    (with dotnetCorePackages;
      combinePackages [
        sdk_7_0
        sdk_8_0
      ])
    libgcc
    nodejs_22
    jdk
    python3
    lua
    php
    bun
  ];

  systemPrograms = with pkgs; [
    home-manager
    kitty
    polkit
    polkit_gnome
    swww
    brightnessctl
    pulseaudio
    glib
    udiskie
    qgnomeplatform
    qgnomeplatform-qt6
    usbutils
    unzip
    upower

    wofi
    waybar
    dunst
    xwaylandvideobridge
  ];

  devTools = with pkgs; [
    docker
    git
    zsh
    vim
    neovim
    newman
    nil
    gopls
    alejandra
    nix-prefetch
    ngspice

    cargo-tauri
    corepack_22
    pkg-config-unwrapped
    python311Packages.pip
  ];

  qt5Packages = with pkgs.libsForQt5; [
    qt5.qtquickcontrols2
    qt5.qtgraphicaleffects
  ];

  themes = with pkgs; [
    catppuccin-gtk
    nordic
    dracula-theme
    nightfox-gtk-theme
    tokyonight-gtk-theme
    rose-pine-gtk-theme
    papirus-icon-theme
    graphite-cursors
  ];

  shellScripts = [
    (import ./scripts/swww-init.nix {inherit pkgs;})
  ];

  use-hyprland-stable = false;
  use-x11-only = false;
in {
  # Include the results of the hardware scan.
  imports = [
    ./system/hardware-configuration.nix
    ./system/zsh.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  # Configure `home-manager` which allows for easy config management
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      marked01one = import ./home.nix;
    };
  };

  # Configure the package manager
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-25.9.0"
      "electron-24.8.6"
    ];
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };

    acpilight.enable = true;
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "perfect-linux"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Enable polkit authenticator agent in systemd
  security.polkit.enable = true;
  systemd = {
    # services = {
    #   sddm-theme-randomizer = {
    #     description = "Theme randomizer for SDDM Sugar Candy";
    #     wantedBy = ["multi-user.target"];
    #     before = ["sddm.service"];
    #     serviceConfig = {
    #       Type = "simple";
    #       ExecStart = "${pkgs}";
    #     };
    #   };
    # };

    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      google-fonts
      (nerdfonts.override {fonts = ["CascadiaCode"];})
      gyre-fonts
    ];

    fontconfig = {
      defaultFonts = {
        serif = ["David Libre"];
        sansSerif = ["TeX Gyre Adventor"];
        monospace = ["CaskaydiaCove Nerd Font"];
      };
    };
  };
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
    excludePackages = with pkgs; [
      xterm
      x11_ssh_askpass
      
    ];

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        rofi
        i3status-rust
        i3blocks
        i3lock
      ];
    };
  };



  services = {
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 50;
      };
    };
    blueman.enable = true;
    upower.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
  };

  services.displayManager = {
    defaultSession = if use-x11-only then "none+i3" else "hyprland";
    
    sddm = {
      enable = true;
      theme = "${import ./modules/sddm/sugar-dark.nix {inherit pkgs;}}";
      wayland.enable = true;
    };
  };

  xdg.mime = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "thunar.desktop";
      "application/pdf" = "org.pwmt.zathura.desktop";
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;

    users.marked01one = {
      isNormalUser = true;
      description = "marked01one";
      extraGroups = ["audio" "networkmanager" "wheel" "docker"];
    };
  };

  # List packages installed in system profile.

  services.flatpak = {
    enable = true;
    packages = flatpakApps;
  };

  programs = {
    nix-ld = {
      enable = true;
      libraries = [
        # Add any missing dynamic libraries for unpacked programs here
        # NOT `environment.systemPackages`
      ];
    };

    hyprland = {
      enable = !use-x11-only;
      package =
        if use-hyprland-stable
        then inputs.hyprland-stable.legacyPackages."${pkgs.system}".hyprland
        else inputs.hyprland.packages."${pkgs.system}".hyprland;

      xwayland.enable = true;
    };
    thunar.enable = true;
    xfconf.enable = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    ssh = {
      enableAskPassword = true;
      askPassword = "";
    };

    firefox = {
      enable = true;
      package = pkgs.firefox-bin;
    };
  };

  environment = {
    pathsToLink = ["/libexec" "/share/zsh"];

    systemPackages =
      shellScripts ++ devTools ++ systemPrograms ++ desktopApps ++ commandLineApps ++ languages ++ qt5Packages ++ themes;

    sessionVariables = {
      # WLR_NO_HARDWARE_CURSORS = "1";
      # NIXOS_OZONE_WL = "1";
      TERMINAL = ["kitty"];
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
  };

  virtualisation.docker = {
    enable = true;
  };

  system.stateVersion = "24.05";
}

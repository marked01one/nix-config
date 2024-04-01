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
    brave
    neovim
    vscode
    obsidian
    space-cadet-pinball
    kicad
    drawio
    discord
    prismlauncher
    waypaper
  ];

  commandLineApps = with pkgs; [
    wget
    curl
    networkmanager
    lsd
    zoxide
    zsh-autocomplete
    zsh-autosuggestions
    neofetch
    btop
    thefuck
  ];

  languages = with pkgs; [
    rustup
    go
    lua
    dotnet-sdk_8
    libgcc
    nodejs_21
    python3
    jdk21
  ];

  systemPrograms = with pkgs; [
    home-manager
    dbus
    kitty
    polkit
    polkit_gnome
    hyprpaper
    rofi
    swww
     
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
  ];
in {
  # Include the results of the hardware scan.
  imports = [ 
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  # Configure `home-manager` which allows for easy config management
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      khoi = import ./home.nix;
    };
  };

  # Configure the package manager
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-25.9.0"
    ];
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
  
  # Enable Nix Commands & Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
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

  environment.pathsToLink = ["/libexec"];

  fonts.packages = with pkgs; [
    google-fonts
    (nerdfonts.override { fonts = ["CascadiaCode"];})
    gyre-fonts
  ];

  # Enable the X11 windowing system.
  # services.xserver = {
  # enable = true; 
  # xkb.layout = "us";
  # xkb.variant = "";
  # excludePackages = [ pkgs.xterm ];
  # displayManager = {
  #   defaultSession = "Hyprland";
      
  #   sddm = {
  #     enable = true;
  #     theme = "";
  #   };
  # };

    # windowManager.i3 = {
    #   enable = true;
    #   package = pkgs.i3-gaps;
    #   extraPackages = with pkgs; [
    #     rofi
    #     i3status-rust
    #     i3blocks
    #     i3lock
    #   ];
    # };
  # };

  services.xserver = {
    enable = true;
    
    displayManager.defaultSession = "hyprland";

    displayManager.sddm = {
      enable = true;
      theme = "${import ./modules/sddm-sugar-dark.nix { inherit pkgs; }}";
      wayland.enable = true;
    };
  };

  xdg.mime = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "thunar.desktop";
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
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;
    
    users.khoi = {
      isNormalUser = true;
      description = "khoi";
      extraGroups = [ "audio" "networkmanager" "wheel" ];
    };
  };

  # List packages installed in system profile.
  environment.systemPackages =
    devTools ++ systemPrograms ++ desktopApps ++ commandLineApps ++ languages;
  
  programs = {
    nix-ld = {
      enable = true;
      libraries = [
        # Add any missing dynamic libraries for unpacked programs here
        # NOT `environment.systemPackages`
      ];
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        # Allow `sudo` to be used with aliases
        sudo = "sudo ";
        ls = "lsd -1";
        ll = "lsd -1 -a -l";
        c = "/run/current-system/sw/bin/code";

        cfnix = "/run/current-system/sw/bin/code ~/SystemFlake";
        update = "sudo nixos-rebuild switch --flake ~/SystemFlake/#perfect-linux";
        
        logout = "pkill -u $(whoami)";
        shutdown = "systemctl poweroff";

        home = "cd ~";
        ".." = "cd ..";
        "..." = "cd ../..";

      };
    };
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
      xwayland.enable = true;
    };
    thunar.enable = true;
    xfconf.enable = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs, 
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./nvidia.nix
  ];

  boot.initrd.availableKernelModules = ["vmd" "xhci_pci" "thunderbolt" "nvme" "usb_storage" "usbhid" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/dc0028fb-8d21-44de-a3ca-95613a7d3827";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/B495-4172";
      fsType = "vfat";
    };

    "/home/marked01one/Shared" = {
      device = "/dev/disk/by-uuid/3d5fbc65-38fc-47a7-8578-bb87cc1a14f8";
      fsType = "ext4";
    };
  };

  swapDevices = [];
  environment.systemPackages = with pkgs; [
    asusctl
    nvtopPackages.full
  ];

  services.asusd.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp108s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}

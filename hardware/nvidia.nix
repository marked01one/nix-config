{ config, lib, pkgs, modulesPath, ... }:

{
  hardware.nvidia = {
    modesetting.enable = true;

    open = false;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.production;

    powerManagement = {
      enable = false;
      finegrained = false;
    };

    prime = {
      offload = {
        enable = true;
	      enableOffloadCmd = true;
      };

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  services.xserver.videoDrivers = ["nvidia"];
}
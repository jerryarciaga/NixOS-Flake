{ config, pkgs, libs, ... }:

{
  boot.kernelParams = [
    "module_blacklist=amdgpu"
  ];

  hardware = {
    graphics.enable = true;
    nvidia = {
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      nvidiaSettings = true;
      modesetting.enable = true;
      powerManagement = {
        enable = true;
        finegrained = false;
      };
    };
  };

  services.xserver.videoDrivers = ["nvidia"];
}

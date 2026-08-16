{ config, pkgs, libs, ... }:

{
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "module_blacklist=amdgpu"
  ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      nvidiaSettings = true;
      modesetting.enable = true;
      nvidiaPersistenced = true;
      forceFullCompositionPipeline = true;

      powerManagement = {
        enable = true;
        finegrained = false;
      };
    };
  };

  
  environment = {
    systemPackages = with pkgs; [
      nvitop
    ];

    sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };

    etc."nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer-pool-in-wayland-compositors.json".text =
      builtins.toJSON {
        rules = [
          {
            pattern = {
              feature = "procname";
              matches = [ "niri" ]; # Or other Wayland WM like 'naitre', 'sway', 'hyprland', ...
            };
            profile = "Limit free buffer pool on Wayland compositors";
          }
        ];
        profiles = [
          {
            name = "Limit free buffer pool on Wayland compositors";
            settings = [
              {
                key = "GLVidHeapReuseRatio";
                value = 0;
              }
              {
                key = "GLUseEGL";
                value = 0;
              }
            ];
          }
        ];
      };
  };

  services.xserver.videoDrivers = ["nvidia"];
  nixpkgs.config.nvidia.acceptLicense = true;

}

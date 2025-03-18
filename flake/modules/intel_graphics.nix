{ config, pkgs, ... }:

{
  boot.kernelParams = [
    "i915.enable_dpcd_backlight=1"
    "i915.force_probe=8086:4680"
  ];
  hardware = {
    intel-gpu-tools = {
      enable = true;
    };
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-ocl
        intel-vaapi-driver
      ];
    };
  };
}

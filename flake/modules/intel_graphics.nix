{ config, pkgs, ... }:

{
  boot.kernelParams = [
    "i915.force_probe=8086:4680"
    "acpi_backlight=video"
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

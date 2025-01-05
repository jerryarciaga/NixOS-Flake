{ config, pkgs, lib, ...}:

{
  environment.systemPackages = with pkgs; [
    yubikey-manager
    yubioath-flutter
    yubico-piv-tool
  ];

  services = {
    udev.packages = with pkgs; [
      yubikey-personalization
    ];
    pcscd.enable = true;
  };
}

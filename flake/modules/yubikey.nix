{ config, pkgs, lib, ...}:

{
  environment.systemPackages = with pkgs; [
    yubikey-manager
    yubioath-flutter
    yubico-piv-tool
    libfido2
  ];

  services = {
    udev.packages = with pkgs; [
      yubikey-personalization
    ];
    pcscd.enable = true;
  };
}

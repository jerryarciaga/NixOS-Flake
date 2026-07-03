{ config, pkgs, lib, inputs, ... }:

{

  # Login manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${config.programs.niri.package}/bin/niri-session";
        user = "jerry";
      };
    };
  };

  # Niri window manager
  programs.niri.enable = true;

  systemd.user.services.niri.enableDefaultPath = false;

  # Niri dependencies
  environment.systemPackages = with pkgs; [
    brightnessctl
  ];

}

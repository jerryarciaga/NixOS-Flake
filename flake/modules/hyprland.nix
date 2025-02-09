{ pkgs, lib, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    brightnessctl
  ];
  security.pam.services.hyprlock = {};
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  };
}

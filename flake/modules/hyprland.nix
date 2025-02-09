{ pkgs, lib, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    brightnessctl
  ];
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  };
}

{ config, pkgs, lib, inputs, ... }:

{

  # Login manager
  programs.regreet = {
    enable = true;
    settings = {
      GTK = {
        application_prefer_dark_theme = true;
        cursor_theme_name = "Adwaita";
        cursor_blink = true;
        font_name = "Cantarell 16";
        icon_theme_name = "Adwaita";
        theme_name = "Adwaita";
      };
      background = {
        path = ./background/gruv-abstract-maze.png;
        fit = "Fill";
      };
      commands = {
        reboot = ["systemctl" "reboot"];
        poweroff = ["systemctl" "poweroff"];
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

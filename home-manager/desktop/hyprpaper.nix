{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprpaper
  ];
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "off";
      preload = [
        "~/.config/wallpaper/fontaine.jpg"
      ];
      wallpaper = [
        ", ~/.config/wallpaper/fontaine.jpg"
      ];
    };
  };
}

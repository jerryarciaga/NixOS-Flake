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
        "~/.config/wallpaper/seven_elements_catpuccin.jpg"
      ];
      wallpaper = [
        ", ~/.config/wallpaper/seven_elements_catpuccin.jpg"
      ];
    };
  };
}

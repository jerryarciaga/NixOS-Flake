{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprpaper
  ];
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      preload = [
        "~/.config/wallpaper/mondstadt.jpg"
        "~/.config/wallpaper/liyue.jpg"
        "~/.config/wallpaper/inazuma.jpg"
        "~/.config/wallpaper/sumeru.jpg"
        "~/.config/wallpaper/fontaine.jpg"
      ];
      wallpaper = [
        ", ~/.config/wallpaper/mondstadt.jpg"
      ];
    };
  };
}

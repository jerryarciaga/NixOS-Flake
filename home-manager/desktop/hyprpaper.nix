{ config, pkgs, ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      preload = [
        "~/.wallpaper/mondstadt.jpg"
        "~/.wallpaper/liyue.jpg"
        "~/.wallpaper/inazuma.jpg"
        "~/.wallpaper/sumeru.jpg"
        "~/.wallpaper/fontaine.jpg"
      ];
      wallpaper = [
        ", ~/.wallpaper/mondstadt.jpg"
      ];
    };
  };
}

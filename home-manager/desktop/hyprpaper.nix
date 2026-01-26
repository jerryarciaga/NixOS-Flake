{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprpaper
  ];
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "off";
      splash = "false";
      preload = [
        "~/.config/wallpaper/seven_elements_ctp.jpg"
      ];
      wallpaper = [
        {
          monitor = "";
          path = "~/.config/wallpaper/seven_elements_ctp.jpg";
          fit_mode = "fill";
        }
      ];
    };
  };
}

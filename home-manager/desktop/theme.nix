{ config, pkgs, lib, wallpaper, ... }:

{

  gtk.gtk4.theme = lib.mkDefault config.gtk.theme;

  stylix = {
    enable = true;
    image = wallpaper;
    base16Scheme =
      "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    targets = {
      alacritty.enable = true;
      firefox.enable = false;
      hyprland.enable = false;
      waybar.enable = true;
    };
  };

}

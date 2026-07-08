{ ... }:
 
{

  xdg.configFile = {
    "niri".source = ./config/niri;
    "wallpaper".source = ./wallpaper;
  };

  programs.swaylock.enable = true; # Super+Alt+L in the default setting (screen locker)
  programs.fuzzel.enable = true; # Super+D in the default setting (app launcher)
  services.mako.enable = true; # notification daemon
  services.swayidle.enable = true; # idle management daemon
  services.polkit-gnome.enable = true; # polkit

}

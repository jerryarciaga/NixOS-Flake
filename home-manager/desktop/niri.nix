{ wallpaper, ... }:
 
{

  xdg.configFile = {
    "niri/config.kdl".source = ./config/niri/config.kdl;
    "niri/modules".source = ./config/niri/modules;
    "niri/wallpaper.kdl".text = ''
      spawn-sh-at-startup "swaybg -m fill -i ${wallpaper}"
    '';
  };


  programs.swaylock.enable = true; # Super+Alt+L in the default setting (screen locker)
  programs.fuzzel.enable = true; # Super+D in the default setting (app launcher)
  services.mako.enable = true; # notification daemon
  services.swayidle.enable = true; # idle management daemon
  services.polkit-gnome.enable = true; # polkit

}

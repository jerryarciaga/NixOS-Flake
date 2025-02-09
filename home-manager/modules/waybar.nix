{ config, pkgs, ... }:

{

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "left";
        width = 10;
        modules-left = [ 
          "hyprland/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "tray"
          "backlight"
          "pulseaudio"
        ];

        "hyprland/workspaces" = {
          active-only = false;
          all-outputs = true;
        };

        "clock" = {
          "format" = "{:%H\n%M}";
          "tooltip-format" = "<tt><small>{calendar}</small></tt>";
          "calendar" =  {
            "mode"          = "year";
            "mode-mon-col"  = 3;
            "weeks-pos"     = "right";
            "on-scroll"     = 1;
            "format" = {
              "months" =     "<span color='#ffead3'><b>{}</b></span>";
              "days" =       "<span color='#ecc6d9'><b>{}</b></span>";
              "weeks" =      "<span color='#99ffdd'><b>W{}</b></span>";
              "weekdays" =   "<span color='#ffcc66'><b>{}</b></span>";
              "today" =      "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          #"format-alt" = "{%H\n%M\n%a\n%d\n%b}";
        };

      };
    };
  };

}

{ config, pkgs, ... }:

{
  programs.hyprlock = {
    enable = true;
    extraConfig = ''
      # Set color variables based on https://github.com/catppuccin/catppuccin
      $color_base = rgb(1e1e2e)
      $color_text = rgb(cdd6f4)
      $color_green = rgb(a6e3a1)
      $color_blue = rgb(89b4fa)

      # Original config submitted by https://github.com/SherLock707
      background {
        monitor =
        path = screenshot
        blur_passes = 2
      }
      
      # Day of week
      label {
        monitor =
        text = cmd[update:18000000] echo "<b> "$(date +'%A')" </b>"
        color = $color_green
        font_size = 65
        font_family = HYWenHei
        position = 0, 200
        halign = right
        valign = bottom
      }
      
      # Date
      label {
        monitor =
        text = cmd[update:18000000] echo "<b> "$(date +'%-d %B %Y')" </b>"
        color = $color_green
        font_size = 65
        font_family = HYWenHei
        position = 0, 0
        halign = right
        valign = bottom
      }
      
      # Time
      label {
        monitor =
        text = cmd[update:1000] echo "<b><big> $(date +"%H:%M") </big></b>" # 24H
        color = $color_green
        font_size = 65
        font_family = HYWenHei
        
        position = 0, 100
        halign = right
        valign = bottom
      }
            
      image {
          monitor =
          path = screenshot
          size = 280 # lesser side if not 1:1 ratio
          rounding = -1 # negative values mean circle
          border_size = 4
          border_color = rgb(221, 221, 221)
          rotate = 0 # degrees, counter-clockwise
          reload_time = -1 # seconds between reloading, 0 to reload with SIGUSR2
          # reload_cmd =  # command to get new path. if empty, old path will be used. don't run "follow" commands like tail -F
          position = 0, 200
          halign = center
          valign = center
      }
    '';
  };
}

{ config, pkgs, ... }:

{
  programs.hyprlock = {
    enable = true;
    extraConfig = ''
      # Original config submitted by https://github.com/SherLock707
      background {
        monitor =
        path = screenshot
        blur_passes = 3
      }
  
      input-field {
        monitor =
        size = 250, 50
        outline_thickness = 3
        dots_size = 0.33 # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.15 # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true
        outer_color = $color5
        inner_color = $color0
        font_color = $color12
        font_family = HYWenHei
        fade_on_empty = false
        placeholder_text = <i>Password...</i> # Text rendered in the input box when it's empty.
        hide_input = false
        
        position = 0, 200
        halign = center
        valign = bottom
      }
      
      # Date
      label {
        monitor =
        text = cmd[update:18000000] echo "<b> "$(date +'%A, %-d %B %Y')" </b>"
        color = $color12
        font_size = 64
        font_family = HYWenHei
        
        position = 0, -150
        halign = center
        valign = top
      }
      
      # Time
      label {
        monitor =
        text = cmd[update:1000] echo "<b><big> $(date +"%H:%M") </big></b>" # 24H
        color = $color15
        font_size = 64
        font_family = HYWenHei
        
        position = 0, 0
        halign = center
        valign = center
      }
      
      # User
      label {
        monitor =
        text =    $USER
        color = $color12
        font_size = 18
        font_family = HYWenHei
        
        position = 0, 100
        halign = center
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

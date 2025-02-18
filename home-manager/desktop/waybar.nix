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
          "tray"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "backlight"
          "pulseaudio"
          "battery"
        ];

        "hyprland/workspaces" = {
          active-only = false;
          all-outputs = true;
        };

        "clock" = {
          "format" = "{:%H\n%M\n\n%d\n%b}";
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

        "battery" = {
          "bat" = "BAT0";
          "interval" = 60;
          "states" = {
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{capacity}%";
        };

      };
    };
    style = ''
      /*
        Catpuccin Mocha Color pallette
        https://unpkg.com/@catppuccin/palette@1.7.1/css/catppuccin.css
      */
        @define-color ctp-mocha-rosewater #f5e0dc;
        @define-color ctp-mocha-flamingo #f2cdcd;
        @define-color ctp-mocha-pink #f5c2e7;
        @define-color ctp-mocha-mauve #cba6f7;
        @define-color ctp-mocha-red #f38ba8;
        @define-color ctp-mocha-maroon #eba0ac;
        @define-color ctp-mocha-peach #fab387;
        @define-color ctp-mocha-yellow #f9e2af;
        @define-color ctp-mocha-green #a6e3a1;
        @define-color ctp-mocha-teal #94e2d5;
        @define-color ctp-mocha-sky #89dceb;
        @define-color ctp-mocha-sapphire #74c7ec;
        @define-color ctp-mocha-blue #89b4fa;
        @define-color ctp-mocha-lavender #b4befe;
        @define-color ctp-mocha-text #cdd6f4;
        @define-color ctp-mocha-subtext1 #bac2de;
        @define-color ctp-mocha-subtext0 #a6adc8;
        @define-color ctp-mocha-overlay2 #9399b2;
        @define-color ctp-mocha-overlay1 #7f849c;
        @define-color ctp-mocha-overlay0 #6c7086;
        @define-color ctp-mocha-surface2 #585b70;
        @define-color ctp-mocha-surface1 #45475a;
        @define-color ctp-mocha-surface0 #313244;
        @define-color ctp-mocha-base #1e1e2e;
        @define-color ctp-mocha-mantle #181825;
        @define-color ctp-mocha-crust #11111b;
      
      * {
        font-family: "HYWenHei";
        font-size: 16px;
        min-width: 8px;
        min-height: 0px;
        border: none;
        border-radius: 8px;
        box-shadow: none;
        text-shadow: none;
        padding: 2px 1px 2px 1px;
        margin: 0px 0px;
      }

      window#waybar {
        transition-property: background-color;
        transition-duration: 0.5s;
        border-radius: 8px;
        background: @background;
      }

      #workspaces button.active {
        background: @ctp-mocha-surface0;
        color: @ctp-mocha-blue;
      }

      window#waybar.visible {
        background: @ctp-mocha-surface0;
        color: @ctp-mocha-teal;
      }

      #workspaces.empty {
        background: @ctp-mocha-surface0;
        color: @ctp-mocha-teal;
      }

      #workspaces.urgent {
        background: @ctp-mocha-red;
        color: @ctp-mocha-teal;
      }

      #clock {
        background: @ctp-mocha-surface0;
        color: @ctp-mocha-sky;
      }

      #backlight {
        border-radius: 4px;
        background: @ctp-mocha-surface0;
        color: @ctp-mocha-yellow;
      }

      #pulseaudio {
        border-radius: 4px;
        background: @ctp-mocha-surface0;
        color: @ctp-mocha-sapphire;
      }

      #battery {
        border-radius: 4px;
        background: @ctp-mocha-surface0;
        color: @ctp-mocha-sapphire;
      }
    '';
  };

}

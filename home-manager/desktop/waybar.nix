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
          "pulseaudio/slider"
          "pulseaudio"
          "battery"
        ];

        "hyprland/workspaces" = {
          active-only = false;
          all-outputs = true;
        };

        "clock" = {
          "format" = "{:%H\n%M\n󰃰\n%d\n%b}";
          #"format-alt" = "{%H\n%M\n%a\n%d\n%b}";
        };

        "pulseaudio/slider" = {
          "min" = 0;
          "max" = 100;
          "orientation" = "vertical";
        };
        "pulseaudio" = {
          "states" = {
            "100" = 100;
            "75" = 75;
            "50" = 50;
            "25" = 25;
            "0" = 0;
          };
          "format-100" = "";
          "format-75" = "";
          "format-50" = "";
          "format-25" = "";
          "format-0" = "";
        };

        "battery" = {
          "bat" = "BAT0";
          "interval" = 60;
          "states" = {
            "full" = 100;
            "95" = 95;
            "90" = 90;
            "80" = 80;
            "70" = 70;
            "60" = 60;
            "50" = 50;
            "40" = 40;
            "30" = 30;
            "20" = 20;
            "critical" = 15;
          };
          "format-full" = "󰁹";
          "format-95" = "󰁹 {capacity}";
          "format-90" = "󰂂 {capacity}";
          "format-80" = "󰂁 {capacity}";
          "format-70" = "󰂀 {capacity}";
          "format-60" = "󰁿 {capacity}";
          "format-50" = "󰁾 {capacity}";
          "format-40" = "󰁽 {capacity}";
          "format-30" = "󰁼 {capacity}";
          "format-20" = "󰁻 {capacity}";
          "format-critical" = "󰂃 {capacity}";
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
        font-family: "HYWenHei, Symbols Nerd Font";
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

      #pulseaudio-slider slider {
        min-height: 0px;
        min-width: 0px;
        opacity: 0;
        background-image: none;
        border: none;
        box-shadow: none;
      }
      #pulseaudio-slider trough {
        min-height: 100px;
        min-width: 10px;
        border-radius: 5px;
        background-color: @ctp-mocha-base;
      }
      #pulseaudio-slider highlight {
        min-width: 10px;
        border-radius: 5px;
        background: @ctp-mocha-green;
      }
      #pulseaudio {
        border-radius: 4px;
        color: @ctp-mocha-green;
      }

      #battery {
        border-radius: 4px;
        background: @ctp-mocha-surface0;
        color: @ctp-mocha-sapphire;
      }
    '';
  };

}

{ config, pkgs, ... }:

{

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "left";
        width = 40;
        spacing = 2;
        modules-left = [ 
          "hyprland/workspaces"
          "tray"
        ];
        modules-right = [
          "backlight/slider"
          "backlight"
          "pulseaudio/slider"
          "pulseaudio"
          "clock"
          "battery"
        ];

        "hyprland/workspaces" = {
          "active-only" = false;
          "all-outputs" = false;
          "persistent-workspaces" = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
          };
        };

        "backlight/slider" = {
          "min" = 0;
          "max" = 100;
          "orientation" = "vertical";
        };
        "backlight" = {
          "format" = "";
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

        "clock" = {
          "format" = "󰃰";
          "tooltip" = true;
          "tooltip-format" = "{:%R %e %B %Y}";
        };

        "battery" = {
          "bat" = "BAT0";
          "interval" = 30;
          "tooltip" = true;
          "tooltip-format" = "{capacity}% {time}";
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
          "format-discharging-95" = "󰁹";
          "format-discharging-90" = "󰂂";
          "format-discharging-80" = "󰂁";
          "format-discharging-70" = "󰂀";
          "format-discharging-60" = "󰁿";
          "format-discharging-50" = "󰁾";
          "format-discharging-40" = "󰁽";
          "format-discharging-30" = "󰁼";
          "format-discharging-20" = "󰁻";
          "format-discharging-critical" = "󰂃";
          "format-charging-95" = "󰂅";
          "format-charging-90" = "󰂋";
          "format-charging-80" = "󰂊";
          "format-charging-70" = "󰢞";
          "format-charging-60" = "󰂉";
          "format-charging-50" = "󰢝";
          "format-charging-40" = "󰂈";
          "format-charging-30" = "󰂇";
          "format-charging-20" = "󰂆";
          "format-charging-critical" = "󰢜";
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

      tooltip {
        background: alpha(@ctp-mocha-surface0, 0.9);
      }
      tooltip label {
        color: @ctp-mocha-text;
      }

      window#waybar {
        transition-property: background-color;
        transition-duration: 0.5s;
        border-radius: 8px;
        background: @background;
      }

      window#waybar.visible {
        background: @ctp-mocha-surface0;
        color: @ctp-mocha-teal;
      }

      #workspaces {
        background: @ctp-mocha-surface0;
        color: @ctp-mocha-blue;
        opacity: 0.90;
      }
      #workspaces button.active {
        background: @ctp-mocha-base;
        color: @ctp-mocha-blue;
        opacity: 0.90;
      }
      #workspaces.urgent {
        background: @ctp-mocha-red;
        color: @ctp-mocha-teal;
        opacity: 0.90;
      }

      #clock {
        background: transparent;
        color: @ctp-mocha-sky;
      }

      #backlight-slider slider {
        min-height: 0px;
        min-width: 0px;
        opacity: 0;
        background-image: none;
        border: none;
        box-shadow: none;
      }
      #backlight-slider trough {
        min-height: 80px;
        min-width: 10px;
        border-radius: 5px;
        background-color: @ctp-mocha-base;
      }
      #backlight-slider highlight {
        min-width: 10px;
        border-radius: 5px;
        background: @ctp-mocha-yellow;
      }
      #backlight {
        border-radius: 4px;
        background: transparent;
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
        min-height: 80px;
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
        background-color: transparent;
      }

      #battery {
        border-radius: 4px;
        color: @ctp-mocha-lavender;
        background-color: transparent;
      }
    '';
  };

}

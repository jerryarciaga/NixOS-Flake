{ config, pkgs, ... }:

{

  # Make wofi detect flatpak applications
  xdg = {
    enable = true;
    systemDirs.data = [
      "${config.home.homeDirectory}/.local/share/flatpak/exports/share"
    ];
  };

  programs.wofi = {
    enable = true;
    settings = {
      location = "center";
      insensitive = true;
      width = 250;
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
      	font-family: "HYWenHei", sans;
      }
      
      window {
      	background-color: transparent;
      }
      
      #input {
      	margin: 5px;
        border: 1px #626880;
        border-style: solid;
      	border-radius: 10px;
      	background-color: #303446;
      	color: #c6d0f5;
        outline-color: #303446;
      }
      
      #input:focus {
        box-shadow: rgba(239, 159, 118, 0.4) 0px 0px 0px 2px, rgba(239, 159, 118, 0.65) 0px 4px 6px -1px, rgba(239, 159, 118, 0.08) 0px 1px 0px inset;
      }
      
      /* #inner-box { */
      /* 	background-color: #303446; */
      /* } */
      
      #outer-box {
      	margin: 2px;
      	padding: 10px;
        border: 1px #626880;
        border-style: solid;
        border-radius: 20px;
      	background-color: #303446;
      }
      
      #scroll {
      	margin: 5px;
      }
      
      #text {
      	padding: 4px;
      	color: #c6d0f5;
      }
      
      #entry:nth-child(even){
      	background-color: #3C4053;
      }
      
      #entry:selected {
      	background-color: #626880;
      }
      
      #text:selected {
      	background: transparent;
      }

    '';
  };

}

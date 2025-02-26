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

{ config, pkgs, ... }:

{

  programs.wofi = {
    enable = true;
    settings = {
      location = "center";
      width = 250;
    };
  };

}

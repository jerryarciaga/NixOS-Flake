{ config, pkgs, ... }:

{
  programs.zathura = {
    enable = true;
    options = {
      recolor-darkcolor = "#cdd6f4";
      recolor-lightcolor = "#1e1e2e";
      recolor-keephue = true;
    };
  };
}

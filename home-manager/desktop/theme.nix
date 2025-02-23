{ config, pkgs, ... }:

{
  catppuccin.gtk = {
    enable = true;
    flavor = "mocha";
    accent = "blue";
    icon = {
      enable = true;
      accent = "blue";
      flavor = "mocha";
    };
  };
}

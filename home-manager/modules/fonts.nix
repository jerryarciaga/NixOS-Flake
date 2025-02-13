{ config, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    font-awesome
    gyre-fonts
    cascadia-code
    nerd-fonts.ubuntu
  ];
}

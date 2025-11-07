{ config, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    gyre-fonts
    cascadia-code
    nerd-fonts.ubuntu
    nerd-fonts.symbols-only
  ];
}

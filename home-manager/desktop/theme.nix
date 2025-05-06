{ pkgs, ... }:

{
  stylix = {
    enable = true;
    base16Scheme =
      "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    targets = {
      alacritty.enable = false;
      firefox.enable = false;
      waybar.enable = false;
    };
  };
}

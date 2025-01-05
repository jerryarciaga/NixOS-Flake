{ config, pkgs, ...}:

{
  users.users.jerry = {
    isNormalUser = true;
    description = "Jerry";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      git
      fastfetch
      firefox
      flatpak
      rofi-wayland
    ];
  };
}

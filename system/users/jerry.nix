{ config, pkgs, ...}:

{
  users.users.jerry = {
    isNormalUser = true;
    description = "Jerry";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}

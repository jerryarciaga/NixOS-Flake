{ config, pkgs, ...}:

{
  users.users.rc = {
    isNormalUser = true;
    description = "RC";
    packages = with pkgs; [
      weechat
    ];
  };
}

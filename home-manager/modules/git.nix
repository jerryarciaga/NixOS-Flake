
{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Jerry Arciaga";
    userEmail = "jerryarciaga11@gmail.com";

    extraConfig = {
      user.signingKey = "637B97EA39C4344993B20E4A28D9FAA9FA130F14";
      core.sshCommand = "ssh -I /run/current-system/sw/lib/libykcs11.so";
      commit.gpgSign = true;
      init.defaultBranch = "main";
    };
  };
}

{ config, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Jerry Arciaga";
        email = "jerryarciaga11@gmail.com";
        signingKey = "637B97EA39C4344993B20E4A28D9FAA9FA130F14";
      };
      core.sshCommand = "ssh -I /run/current-system/sw/lib/libykcs11.so";
      commit.gpgSign = true;
      init.defaultBranch = "main";
    };
  };
}

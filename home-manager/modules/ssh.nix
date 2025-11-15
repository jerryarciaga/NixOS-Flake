{ config, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        forwardAgent = false;
        addKeysToAgent = "no";
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = config.home.homeDirectory + "/.ssh/known_hosts";
        controlMaster = "no";
        controlPersist = "no";
      };
      "GitHub" = {
        hostname = "github.com";
        user = "git";
        identityFile = config.home.homeDirectory + "/.ssh/github_ssh";
      };
    };
  };
}

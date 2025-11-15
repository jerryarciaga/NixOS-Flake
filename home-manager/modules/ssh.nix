{ config, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    package = pkgs.openssh;
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
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = config.home.homeDirectory + "/.ssh/github_ssh";
      };
    };
  };
}

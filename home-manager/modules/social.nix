{ pkgs, ... }:

{
  programs = {
    thunderbird.enable = true;
    discord.enable = true;
  };

  home.packages = [ pkgs.teams-for-linux ];
}

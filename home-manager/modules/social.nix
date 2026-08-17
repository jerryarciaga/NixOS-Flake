{ pkgs, ... }:

{
  programs.discord.enable = true;
  home.packages = [ pkgs.teams-for-linux ];
}

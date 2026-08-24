{ pkgs, ... }:

{
  programs.vesktop.enable = true;
  home.packages = [ pkgs.teams-for-linux ];
}

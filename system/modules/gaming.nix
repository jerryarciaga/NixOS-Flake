{ pkgs, ... }:

{

  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
    gamemode.enable = true;
  };

  environment.systemPackages = with pkgs; [
    protonup-qt
  ];

}

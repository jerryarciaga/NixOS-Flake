{ inputs, pkgs, ... }:

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

  nix.settings = inputs.aagl.nixConfig;
  programs.anime-game-launcher.enable = true;

}

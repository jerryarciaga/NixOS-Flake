{ ... }:

{

  hardware.graphics = {
    enable = true;
    enable32bit = true;
  };

  programs = {
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    gamemode.enable = true;
  };

}

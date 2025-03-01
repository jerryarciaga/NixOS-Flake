{ config, pkgs, ... }:

{
  home.username = "jerry";
  home.homeDirectory = "/home/jerry";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    flatpak
    slurp
    grim
    xfce.thunar
  ];

  home.file = {
    ".profile" = {
      text = ''
        . "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh"
      '';
    };

    # Use wallpaper for desktop/hyprpaper.nix
    ".config/wallpaper".source = ./wallpaper;

    # Custom fonts
    ".local/share/fonts/zh-cn.ttf".source = ./fonts/zh-cn.ttf;
    ".local/share/fonts/Genshin_Elements.ttf".source = ./fonts/Genshin_Elements.ttf;
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Allow Flatpak applications to run via desktop launcher (wofi).
  xdg = {
    enable = true;
    systemDirs.data = [
      "${config.home.homeDirectory}/.local/share/flatpak/exports/share"
    ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

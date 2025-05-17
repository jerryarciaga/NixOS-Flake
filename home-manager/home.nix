{ config, pkgs, ... }:

{
  home.username = "jerry";
  home.homeDirectory = "/home/jerry";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    flatpak
    github-cli
    obsidian
    slurp
    grim
    xfce.thunar
    xfce.tumbler
    hyprshot
    imv
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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Bashrc
  programs.bash = {
    enable = true;
    initExtra = ''
      # include .profile if it exists
      [[ -f ~/.profile ]] && . ~/.profile
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

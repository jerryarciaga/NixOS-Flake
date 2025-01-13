{ config, pkgs, ... }:

{
  home.username = "jerry";
  home.homeDirectory = "/home/jerry";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    flatpak
    rofi-wayland
    slurp
    grim
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

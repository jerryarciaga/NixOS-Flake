{ config, pkgs, ... }:

{
  home = {
    username = "jerry";
    homeDirectory = "/home/jerry";
    preferXdgDirectories = true;
    stateVersion = "24.11"; # Please read the comment before changing.

    packages = with pkgs; [
      yubico-piv-tool
      flatpak
      github-cli
      thunar
      tumbler
      hyprshot
      imv
    ];

    file = {
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
    bashrcExtra = ''
      nixos_rebuild_switch() {
        if [[ -d /build ]]; then
          export TMPDIR="/build"
        fi

        if [[ -d $HOME/.dotfiles/nixos ]]; then
          sudo nixos-rebuild switch --flake $HOME/.dotfiles/nixos
        else
          sudo nixos-rebuild switch --flake .
        fi

        if [[ -v TMPDIR ]]; then
          unset TMPDIR
        fi
      }

      nixos_cleanup() {
        sudo nix store optimise
        sudo nix-collect-garbage --delete-older-than 2d
        nix-collect-garbage --delete-older-than 2d
      }

      nix_build_iso() {
        if [[ -d $HOME/.dotfiles/nixos ]]; then
          FLAKE="$HOME/.dotfiles/nixos"
        else
          FLAKE=$PWD
        fi
        nix build \
          $FLAKE/#nixosConfigurations.coffeemaker.config.system.build.isoImage \
          -o coffeemaker
        unset FLAKE
      }
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

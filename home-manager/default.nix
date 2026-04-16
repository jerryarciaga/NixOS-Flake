{ inputs }:

let
  system = "x86_64-linux";
  pkgs = inputs.nixpkgs.legacyPackages.${system};

  mkHome = { modules ? [ ] }:
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [
        ./home.nix

        # Hyprland dots
        ./desktop/theme.nix
        ./desktop/hyprland.nix
        ./desktop/hyprpaper.nix
        ./desktop/hyprlock.nix
        ./desktop/waybar.nix
        ./desktop/wofi.nix

        # Theme
        inputs.stylix.homeModules.stylix
        inputs.catppuccin.homeModules.catppuccin

        # App configs
        ./modules/alacritty.nix
        ./modules/git.nix
        ./modules/neovim.nix
        ./modules/zathura.nix
        ./modules/firefox.nix
        ./modules/fonts.nix

        # Services
        ./modules/ssh.nix
      ] ++ modules;

      # Use extraSpecialArgs
      # to pass through arguments to home.nix
      extraSpecialArgs = {
        inherit inputs;
      };
    };
in

{

  jerry = mkHome { };

}

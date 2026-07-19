{ inputs }:

let
  system = "x86_64-linux";
  pkgs = inputs.nixpkgs.legacyPackages.${system};

  mkHome = {
    modules ? [ ],
    wallpaper ? ./desktop/wallpaper/gruv_coffee_battery.png 
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [
        ./home.nix

        # Niri dots
        ./desktop/niri.nix
        ./desktop/theme.nix
        ./desktop/eww.nix

        # Theme
        inputs.stylix.homeModules.stylix

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
        inherit inputs wallpaper;
      };
    };
in

{

  jerry = mkHome { };

}

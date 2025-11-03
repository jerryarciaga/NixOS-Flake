{
  description = "Home Manager configuration of jerry";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixneovim = {
      url = "github:nixneovim/nixneovim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    stylix,
    catppuccin,
    nixneovim,
    ...
  } @inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      defaultModules = [
          ./home.nix

          # Hyprland dots
          ./desktop/theme.nix
          ./desktop/hyprland.nix
          ./desktop/hyprpaper.nix
          ./desktop/hyprlock.nix
          ./desktop/waybar.nix
          ./desktop/wofi.nix

          # Theme
          stylix.homeModules.stylix
          catppuccin.homeModules.catppuccin

          # App configs
          ./modules/alacritty.nix
          ./modules/git.nix
          ./modules/neovim.nix
          ./modules/zathura.nix
          ./modules/firefox.nix
          ./modules/fonts.nix

          # Plugins
          nixneovim.nixosModules.default
        ];
      defaultConfig = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = defaultModules;

        # Use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = {
          inherit inputs;
        };
      };
      gamingConfig = defaultConfig // {
        modules = defaultModules ++ [
          ./modules/gaming.nix
        ];
      };
    in {
      homeConfigurations."jerry" = defaultConfig;
      homeConfigurations."jerry@frappuccino" = gamingConfig;
    };
}

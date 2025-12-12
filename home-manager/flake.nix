{
  description = "Home Manager configuration of jerry";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
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
    in {
      homeConfigurations."jerry" = home-manager.lib.homeManagerConfiguration {
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

          # Services
          ./modules/ssh.nix
        ];

        # Use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = {
          inherit inputs;
        };
      };
    };
}

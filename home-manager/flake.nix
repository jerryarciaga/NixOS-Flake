{
  description = "Home Manager configuration of jerry";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixneovimplugins = {
      # Use fork temporarily until issue is resolved
      #   https://github.com/NixNeovim/NixNeovimPlugins/issues/124
      # Pull request submitted
      #   https://github.com/NixNeovim/NixNeovimPlugins/pull/127
      # url = "github:NixNeovim/NixNeovimPlugins";
      url = "github:jerryarciaga/NixNeovimPlugins/fix-clashes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    catppuccin,
    nixneovimplugins,
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
          catppuccin.homeManagerModules.catppuccin

          # App configs
          ./modules/alacritty.nix
          ./modules/git.nix
          ./modules/neovim.nix
          ./modules/zathura.nix
          ./modules/firefox.nix
          ./modules/fonts.nix
        ];

        # Use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = {
          inherit inputs;
        };
      };
    };
}

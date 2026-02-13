{
  description = "NixOS Config with SecureBoot enabled";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # System inputs
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.3";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home Manager inputs
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
  };

  outputs = {
    self,
    nixpkgs,
    lanzaboote,
    home-manager,
    stylix,
    catppuccin,
    ...
  } @ inputs:
  
  let
    # Modules all my hosts should have in common go here.
    defaultSystemModules = [
      # Default config
      ./system/host/configuration.nix

      # Secureboot (lanzaboote)
      # NOTE: Comment these out during first install (nixos-install).
      lanzaboote.nixosModules.lanzaboote
      ./system/modules/secureboot.nix

      # User
      ./system/users/jerry.nix

      # Audio
      ./system/modules/audio.nix
      
      # Desktop
      ./system/modules/hyprland.nix

      # Apps
      ./system/modules/yubikey.nix
    ];
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    nixosConfigurations = {

      # Coffee Maker | Minimal NixOS installation media
      coffeemaker = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./system/modules/installer.nix
        ];
      };

      # Latte | Lenovo Yoga 7 2-in-1 16IML9
      latte = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = defaultSystemModules ++ [
          ./system/host/latte/hostname.nix
          ./system/users/rc.nix
          ./system/host/latte/hardware-configuration.nix
          ./system/modules/intel_graphics.nix
          ./system/modules/tailscale.nix
        ];
      };

      # Cappuccino | Dell Optiplex Tower 7010
      cappuccino = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = defaultSystemModules ++ [
          ./system/host/cappuccino/hostname.nix
          ./system/users/rc.nix
          ./system/host/cappuccino/hardware-configuration.nix
          ./system/modules/intel_graphics.nix
          ./system/modules/virt-manager.nix
          ./system/modules/tailscale.nix
          ./system/modules/virtualbox.nix
        ];
      };

      # Frappuccino | HP Omen 8746
      frappuccino = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = defaultSystemModules ++ [
          ./system/host/frappuccino/hostname.nix
          ./system/host/frappuccino/hardware-configuration.nix
          ./system/modules/nvidia_graphics.nix
        ];
      };

      # Macchiato | Dell Inspiron 24 Model 
      macchiato = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = defaultSystemModules ++ [
          ./system/host/macchiato/hostname.nix
          ./system/host/macchiato/hardware-configuration.nix
          ./system/modules/nvidia_graphics.nix
        ];
      };

      # Americano | HP ProBook 640 G4
      americano = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = defaultSystemModules ++ [
          ./system/host/americano/hostname.nix
          ./system/host/americano/hardware-configuration.nix
          ./system/modules/intel_graphics.nix
        ];
      };
    };

    homeConfigurations."jerry" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [
        ./home-manager/home.nix

        # Hyprland dots
        ./home-manager/desktop/theme.nix
        ./home-manager/desktop/hyprland.nix
        ./home-manager/desktop/hyprpaper.nix
        ./home-manager/desktop/hyprlock.nix
        ./home-manager/desktop/waybar.nix
        ./home-manager/desktop/wofi.nix

        # Theme
        stylix.homeModules.stylix
        catppuccin.homeModules.catppuccin

        # App configs
        ./home-manager/modules/alacritty.nix
        ./home-manager/modules/git.nix
        ./home-manager/modules/neovim.nix
        ./home-manager/modules/zathura.nix
        ./home-manager/modules/firefox.nix
        ./home-manager/modules/fonts.nix

        # Services
        ./home-manager/modules/ssh.nix
      ];

      # Use extraSpecialArgs
      # to pass through arguments to home.nix
      extraSpecialArgs = {
        inherit inputs;
      };
    };

  };
}

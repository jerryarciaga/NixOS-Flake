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
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    defaultSystemModules = [
      ./system/configuration.nix

      # NOTE: Comment these out during first install (nixos-install).
      lanzaboote.nixosModules.lanzaboote
      ./system/modules/secureboot.nix

      ./system/users/jerry.nix
      ./system/modules/yubikey.nix
    ];

    desktopModules = [
      ./system/modules/luks.nix
      ./system/modules/displaymanager.nix
      ./system/modules/hyprland.nix
      ./system/modules/audio.nix
    ];

    mkSystem = { hostName, modules }:
      nixpkgs.lib.nixosSystem {
        system = system;
        modules = [ ./system/hardware-configuration/${hostName}.nix ] ++
          defaultSystemModules ++ modules;
        specialArgs = {
          inherit inputs hostName;
        };
      };
  in
  {
    nixosConfigurations = {

      # Coffee Maker | Minimal NixOS installation media
      coffeemaker = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          ./system/modules/installer.nix
        ];
      };

      # Latte | Lenovo Yoga 7 2-in-1 16IML9
      latte = mkSystem {
        hostName = "latte";
        modules = [
          ./system/users/rc.nix
          ./system/modules/intel-graphics.nix
          ./system/modules/flatpak.nix
          ./system/modules/tailscale.nix
        ] ++ desktopModules;
      };

      # Cappuccino | Dell Optiplex Tower 7010
      cappuccino = mkSystem {
        hostName = "cappuccino";
        modules = [
          ./system/users/rc.nix
          ./system/modules/intel-graphics.nix
          ./system/modules/flatpak.nix
          ./system/modules/virt-manager.nix
          ./system/modules/tailscale.nix
          ./system/modules/virtualbox.nix
        ] ++ desktopModules;
      };

      # Frappuccino | HP Omen 8746
      frappuccino = mkSystem {
        hostName = "frappuccino";
        modules = [
          ./system/modules/nvidia-graphics.nix
          ./system/modules/flatpak.nix
        ] ++ desktopModules;
      };

      # Macchiato | Dell Inspiron 24 Model 
      macchiato = mkSystem {
        hostName = "macchiato";
        modules = [
          ./system/modules/nvidia-graphics.nix
        ] ++ desktopModules;
      };

      # Americano | HP ProBook 640 G4
      americano = mkSystem {
        hostName = "americano";
        modules = [
          ./system/modules/intel-graphics.nix
        ] ++ desktopModules;
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

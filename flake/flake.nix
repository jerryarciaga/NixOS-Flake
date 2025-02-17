{
  description = "NixOS Config with SecureBoot enabled";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = {
    self,
    nixpkgs,
    lanzaboote,
    ...
  } @ inputs:
  
  let
    # Modules all my hosts should have in common go here.
    defaultModules = [
      # Default config
      ./host/configuration.nix

      # Secureboot (lanzaboot)
      # NOTE: Comment these out during first install (nixos-install).
      lanzaboote.nixosModules.lanzaboote
      ./modules/secureboot.nix
      
      # Desktop
      ./modules/hyprland.nix

      # Apps
      ./modules/yubikey.nix
    ];
  in
  {
    nixosConfigurations = {

      # Latte | Lenovo Yoga 7 2-in-1 16IML9
      latte = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = defaultModules ++ [
          ./host/latte/hostname.nix
          ./host/latte/hardware-configuration.nix
          ./modules/intel_graphics.nix
        ];
      };

      # Cappuccino | Dell Optiplex Tower 7010
      cappuccino = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = defaultModules ++ [
          ./host/cappuccino/hostname.nix
          ./host/cappuccino/hardware-configuration.nix
          ./modules/intel_graphics.nix
        ];
      };

      # Coffee | Acer TravelMate
      coffee = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = defaultModules ++ [
          ./host/coffee/hostname.nix
          ./host/coffee/hardware-configuration.nix
          ./modules/intel_graphics.nix
        ];
      };

      # Americano | HP ProBook 640 G4
      americano = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = defaultModules ++ [
          ./host/americano/hostname.nix
          ./host/americano/hardware-configuration.nix
          ./modules/intel_graphics.nix
        ];
      };


    };
  };
}

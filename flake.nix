{
  description = "NixOS Config with SecureBoot enabled";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    lanzaboote,
    ...
  }:
  
  let
    # Modules all my hosts should have in common go here.
    defaultModules = [
      # Default config + secureboot (lanzaboot)
      ./host/configuration.nix
      lanzaboote.nixosModules.lanzaboote
      ./modules/secureboot.nix
      
      # Desktop
      ./modules/qtile.nix

      # Apps
      ./modules/yubikey.nix
    ];
  in
  {
    nixosConfigurations = {

      # Cappuccino | Dell Optiplex Tower 7010
      cappuccino = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = defaultModules ++ [
          ./host/cappuccino/hardware-configuration.nix
          ./host/cappuccino/hostname.nix
        ];
      };

      # Coffee | Acer TravelMate
      coffee = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = defaultModules ++ [
          ./host/coffee/hardware-configuration.nix
          ./host/coffee/hostname.nix
        ];
      };

    };
  };
}

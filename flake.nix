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
  
  {
    nixosConfigurations = {
      cappuccino = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./host/cappuccino/hardware-configuration.nix
          ./host/cappuccino/hostname.nix

          # Default config + secureboot (lanzaboot)
          ./host/configuration.nix
          lanzaboote.nixosModules.lanzaboote
          ./modules/secureboot.nix
          
          # Desktop + Apps
          ./modules/qtile.nix
          ./modules/yubikey.nix
        ];
      };
    };
  };
}

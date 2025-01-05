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
      default = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # Default config + secureboot (lanzaboot)
          ./host/default/configuration.nix
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

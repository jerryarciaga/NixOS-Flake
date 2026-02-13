{
  description = "NixOS Config with SecureBoot enabled";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.3";
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
    defaultSystemModules = [
      # Default config
      ./system/host/configuration.nix

      # Secureboot (lanzaboote)
      # NOTE: Comment these out during first install (nixos-install).
      lanzaboote.nixosModules.lanzaboote
      ./system/modules/secureboot.nix

      # Audio
      ./system/modules/audio.nix
      
      # Desktop
      ./system/modules/hyprland.nix

      # Apps
      ./system/modules/yubikey.nix
    ];
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
  };
}

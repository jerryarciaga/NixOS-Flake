  # If starting out for the first time, make sure that Secure Boot is disabled the first time. Then do the following to setup SecureBoot:
  # 1. Run `sudo sbctl create-keys`. You may want to do `sudo sbctl setup --migrate` if you have those keys in `/etc/secureboot`.
  # 2. Run `nixos-install --flake <here>` to start the build.
  # 3. After buillding, check that everything went through by `sbctl verify`. You should see a lot of EFI files being signed.
  # 4. Reboot your system, Enabling SecureBoot or Setup mode. If you can't find an option for Setup mode, removing the Platform key might work.
  # 5. Enroll your keys using Microsoft keys by `sudo sbctl enroll-keys --microsoft`.
  # 6. Disable Setup mode at this point. After rebooting, run `bootctl status` to confirm that SecureBoot is now setup.

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

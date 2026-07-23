{ inputs }:

let
  system = "x86_64-linux";

  defaultSystemModules = [
    ./configuration.nix
    inputs.disko.nixosModules.disko

    # NOTE: Comment these out during first install (nixos-install).
    inputs.lanzaboote.nixosModules.lanzaboote
    ./modules/secureboot.nix

    ./users/jerry.nix
    ./modules/yubikey.nix
  ];

  desktopModules = [
    ./modules/luks.nix
    ./modules/display-window-manager.nix
    ./modules/audio.nix
  ];

  mkSystem = {
    hostName,
    device ? "/dev/nvme0n1",
    diskoModule ? [ ./hardware-configuration/disko.nix ],
    modules
  }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [ ./hardware-configuration/${hostName}.nix ] ++
        diskoModule ++ defaultSystemModules ++ modules;
      specialArgs = {
        inherit inputs device hostName;
      };
    };
in

{

  # Coffee Maker | Minimal NixOS installation media
  coffeemaker = inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
      ./modules/installer.nix
    ];
  };
  
  # Latte | Lenovo Yoga 7 2-in-1 16IML9
  latte = mkSystem {
    hostName = "latte";
    diskoModule = [ ];
    modules = [
      ./users/rc.nix
      ./modules/intel-graphics.nix
      ./modules/flatpak.nix
      ./modules/virt-manager.nix
      ./modules/tailscale.nix
    ] ++ desktopModules;
  };
  
  # Cappuccino | Dell Optiplex Tower 7010
  cappuccino = mkSystem {
    hostName = "cappuccino";
    diskoModule = [ ];
    modules = [
      ./users/rc.nix
      ./modules/intel-graphics.nix
      ./modules/flatpak.nix
      ./modules/virt-manager.nix
      ./modules/tailscale.nix
    ] ++ desktopModules;
  };
  
  # Frappuccino | HP Omen 8746
  frappuccino = mkSystem {
    hostName = "frappuccino";
    modules = [
      ./modules/nvidia-graphics.nix
      ./modules/flatpak.nix
    ] ++ desktopModules;
  };
  
  # Macchiato | Dell Inspiron 24 Model 
  macchiato = mkSystem {
    hostName = "macchiato";
    diskoModule = [ ];
    modules = [
      ./modules/nvidia-graphics.nix
    ] ++ desktopModules;
  };
  
  # Americano | HP ProBook 640 G4
  americano = mkSystem {
    hostName = "americano";
    diskoModule = [ ];
    modules = [
      ./modules/intel-graphics.nix
    ] ++ desktopModules;
  };

}

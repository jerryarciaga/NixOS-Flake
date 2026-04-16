{ inputs }:

let
  system = "x86_64-linux";

  defaultSystemModules = [
    ./configuration.nix

    # NOTE: Comment these out during first install (nixos-install).
    inputs.lanzaboote.nixosModules.lanzaboote
    ./modules/secureboot.nix

    ./users/jerry.nix
    ./modules/yubikey.nix
  ];

  desktopModules = [
    ./modules/luks.nix
    ./modules/display-manager.nix
    ./modules/hyprland.nix
    ./modules/audio.nix
  ];

  mkSystem = { hostName, modules }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [ ./hardware-configuration/${hostName}.nix ] ++
        defaultSystemModules ++ modules;
      specialArgs = {
        inherit inputs hostName;
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
    modules = [
      ./users/rc.nix
      ./modules/intel-graphics.nix
      ./modules/flatpak.nix
      ./modules/tailscale.nix
    ] ++ desktopModules;
  };
  
  # Cappuccino | Dell Optiplex Tower 7010
  cappuccino = mkSystem {
    hostName = "cappuccino";
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
    modules = [
      ./modules/nvidia-graphics.nix
    ] ++ desktopModules;
  };
  
  # Americano | HP ProBook 640 G4
  americano = mkSystem {
    hostName = "americano";
    modules = [
      ./modules/intel-graphics.nix
    ] ++ desktopModules;
  };

}

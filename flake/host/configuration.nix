{ config, pkgs, ... }:

{
  imports =
    [ 
      ../users/jerry.nix
      ../users/rc.nix
    ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # If you are experiencing timeouts due to slow internet (curl error 200),
  # the default setting for stalled-download-timeout may prevent
  # you from installing your packages. If this happens, uncomment the
  # following line, increase the default setting then run the install
  # command again.
  # nix.settings.stalled-download-timeout = 300;

  # Bootloader.
	boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      enable = true;
      luks.devices = {
        luksroot = {
          device = "/dev/disk/by-label/nixos";
        };
      };
    };
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
	
  # Desktop - Display and Window Management
  services = {
    displayManager = {
      gdm.enable = true;
    };
  };

  # Flatpak
  services.flatpak.enable = true;

  # GNUPG
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Flatpak specific stuff
  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = [
          "gtk"
        ];
      };
    };
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    dbus
    vim
    wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}

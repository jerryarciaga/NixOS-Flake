# If starting out for the first time, make sure that Secure Boot is disabled the first time. Then do the following to setup SecureBoot:
# 1. Run `sudo sbctl create-keys`. You may want to do `sudo sbctl setup --migrate` if you have those keys in `/etc/secureboot`.
# 2. Run `nixos-install --flake <here>` to start the build.
# 3. After buillding, check that everything went through by `sbctl verify`. You should see a lot of EFI files being signed.
# 4. Reboot your system, Enabling SecureBoot or Setup mode. If you can't find an option for Setup mode, removing the Platform key might work.
# 5. Enroll your keys using Microsoft keys by `sudo sbctl enroll-keys --microsoft`.
# 6. Disable Setup mode at this point. After rebooting, run `bootctl status` to confirm that SecureBoot is now setup.

{pkgs, lib, ...}:

{
  environment.systemPackages = with pkgs; [
    sbctl
  ];
  boot = {
    loader = {
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = lib.mkForce false;
    };

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };
}

{ ... }:

{
  boot.initrd.luks.devices = {
    luksroot.device = "/dev/disk/by-label/nixos";
  };
}

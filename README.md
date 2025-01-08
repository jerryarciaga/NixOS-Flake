# NixOS Flake

This project shows my progress as I learn and move into NixOS.

# Features and Installed Software
* Full-disk encryption with LVM.
* Qtile on Wayland
* YubiKey

# Installation
This installation instructions are specific to how I use my system. You might need to modify to suit your needs. But, for first-time installation, we generally follow the manual installation instructions until right before the nixos-generate command.

## Setup your partitions
In this section, I have created 2 partitions: `boot` and LVM. When encrypting the LVM partition, be sure to assign a label as well so you can access it as `/dev/disk/by-label/<label>`. On my installation, the label is `nixos`, so at the very least, encrypt your LVM partition using the following:
```
# cryptsetup luksFormat --label nixos /dev/<partition>
```

## Logical Volume Management and Formatting
After decrypting this partition, setup the LVM partition. As long as you can mount the root partition and boot partition is formatted with `mkfs.vfat`, you should be good. My `lsblk` output should give an idea on how my volumes and filesystems are set up.
```
$ lsblk

NAME                        MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
nvme0n1                     259:0    0 931.5G  0 disk  
├─nvme0n1p1                 259:1    0     2G  0 part  /boot
└─nvme0n1p2                 259:2    0 929.5G  0 part  
  └─luksroot                254:0    0 929.5G  0 crypt 
    ├─cappuccino_vg-tmp     254:1    0     1G  0 lvm   /tmp
    ├─cappuccino_vg-var     254:2    0     2G  0 lvm   /var
    ├─cappuccino_vg-var_log 254:3    0    50G  0 lvm   /var/log
    ├─cappuccino_vg-swap    254:4    0    16G  0 lvm   [SWAP]
    ├─cappuccino_vg-root    254:5    0   100G  0 lvm   /nix/store
    └─cappuccino_vg-home    254:6    0 760.5G  0 lvm   /home
```

## Mount partitions
The root partition is mounted in `/mnt`. It is recommmended to mount the /boot partition with the option `umask=077` to prevent non-root users accessing the boot partition.
```
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot
```
It is up to you how you want to mount the rest of the partitions.

## NixOS Flake
For this, you need to clone this repo, `cd` into it, generate hardware configuration then run the install command. I also need to test this out.
```
$ git clone https://github.com/jerryarciaga/NixOS-Flake flake
$ cd flake
$ sudo nixos-generate-config --root /mnt --show-hardware-config | tee ./host/default/hardware-configuration.nix
```
## Secure boot
According to [lanzaboote documentation](https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md), you need to first setup systemd-boot before switching to lanzaboote. This means you can't go straight into setting sbctl up during the installation phase. Because of this, prior to running nixos-install, you have to first comment the following lines out in `flake.nix`
```
$ cat flake.nix

# lanzaboote.nixosModules.lanzaboote
# ./modules/secureboot.nix

```

## Install
At this point, everything should be ready to for installation. Again, I still have to test this.
```
# nixos-install --root --flake path://${PWD}#<hostname>
```
## Secure Boot
After installation, you can clone this repository again, ensuring those two lines before are now uncommented. At this point you need to do the following:
### Create keys
```
$ sudo sbctl create-keys # Might have to do sbctl set --migrate if needed
```
### Clone and rebuild
Cloning the repository should have the secure boot lines uncommented. You can check just to be sure.
```
$ git clone https://github.com/jerryarciaga/NixOS-Flake nixos
$ sudo nixos-rebuild switch --flake path://${PWD}
$ reboot
```
### Set boot options to Setup Mode
This step varies from device to device. It is usually done by setting to *audit mode*, *setup mode*, or deleting platform keys (or maybe all secure boot keys).
### Enroll keys
After booting up, these keys should now be ready for enrollment. Booting it up should automatically disable setup mode.
```
$ sudo sbctl enroll-keys --microsoft
```
## Verify secure boot
After booting up, check to see that Secure Boot is now enabled.
```
$ sbctl status
```
Congrats! You can follow directions.

## Post Installation

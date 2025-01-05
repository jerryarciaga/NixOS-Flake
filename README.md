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

## Secure Boot
I still have to test this if it works using a whole new machine. The machine has to have SecureBoot disabled first, then in Setup Mode. `sbctl` is probably not installed by default on the LiveISO. Basically, create secureboot keys using `sbctl` then enroll them.
```
# sbctl create-keys -e /mnt/var/lib/sbctl
```


## NixOS Flake
For this, you need to clone this repo, `cd` into it, generate hardware configuration then run the install command. I also need to test this out.
```
$ git clone https://github.com/jerryarciaga/NixOS-Flake flake
$ cd flake
$ sudo nixos-generate-config --root /mnt --show-hardware-config | tee ./host/default/hardware-configuration.nix
```

## Set hostname
I have separated this file from the config so I can put in different hostnames on different machines.
```
$ cat ./host/default/hostname.nix 

{ config, pkgs, ... }:

{
  networking.hostName = "cappuccino";
}
```

## Install
At this point, everything should be ready to for installation. Again, I still have to test this.
```
# nixos-install --root --flake path://${PWD}#default
# sbctl --verify
# reboot # At this point, ensure secureboot is back on
```

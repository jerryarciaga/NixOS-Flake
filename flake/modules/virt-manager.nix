{ ... }:

{
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["jerry"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}

{ ... }:

{
  nixpkgs.config.allowUnfree = true;
  users.extraGroups.vboxusers.members = [
    "jerry"
  ];

  virtualisation.virtualbox.host = {
    enable = true;
    enableKvm = true;
    addNetworkInterface = false;
    enableExtensionPack = true;
  };
}

{ pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];

  # Programs and features
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
  environment.systemPackages = with pkgs; [ 
    git
  ];
}

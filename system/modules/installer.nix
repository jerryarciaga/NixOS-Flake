{ pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];

  # Nix Experimental Features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Networking
  networking = {
    hostName = "coffee-maker";
    networkmanager.enable = true;
  };

  # Programs and features
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      configure.customRC = ''
        set mouse=a
        set number relativenumber
        
        set softtabstop=2
        set tabstop=2
        set shiftwidth=2
        
        set expandtab
        set smartindent
      '';
    };
  };
  environment.systemPackages = with pkgs; [ 
    git
    wget
    w3m
    dmidecode
  ];
}

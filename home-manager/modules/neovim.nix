{ pkgs, inputs, ... }:

{

  nixpkgs.overlays = [
    inputs.nixneovim.overlays.default
  ];

  programs.nixneovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfigVim = ''
      set mouse=a
      set number relativenumber
      
      set softtabstop=2
      set tabstop=2
      set shiftwidth=2
      
      set expandtab
      set smartindent
    '';
    plugins = {
      airline = {
        enable = true;
        powerline = true;
        theme = "catppuccin";
      };
    };
    colorschemes = {
      catppuccin = {
        enable = true;
        flavour = "mocha";
        dimInactive = {
          enabled = true;
          percentage = 0.15;
        };
      };
    };
  };

}

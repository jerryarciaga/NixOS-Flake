{ config, pkgs, inputs, ... }:

{

  nixpkgs.overlays = [
    inputs.nixneovimplugins.overlays.default
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-airline
      lazy-nvim
      pkgs.vimExtraPlugins.catppuccin
    ];
    extraConfig = ''
      colorscheme catppuccin-mocha

      set mouse=a
      set number relativenumber

      set softtabstop=2
      set tabstop=2
      set shiftwidth=2

      set expandtab
      set smartindent
    '';
  };

}

{ config, pkgs, ... }:

{

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [ vim-airline ];
    extraConfig = ''
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

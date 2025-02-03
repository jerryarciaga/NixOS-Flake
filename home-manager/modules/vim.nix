{ config, pkgs, ... }:

{

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline ];
    settings = { ignorecase = true; };
    extraConfig = ''
      set mouse=a
      set number

      set softtabstop=2
      set tabstop=2
      set shiftwidth=2

      set expandtab
      set smartindent
    '';
  };

}

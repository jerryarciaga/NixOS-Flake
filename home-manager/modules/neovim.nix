{ pkgs, ... }:

{

  programs.neovim= {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./config/nvim/init.vim;
    plugins = [
      pkgs.vimPlugins.vim-airline
      {
        plugin = pkgs.vimPlugins.vim-airline-themes;
        config = "let g:airline_theme = 'base16_gruvbox_dark_medium'";
      }
    ];
  };

}

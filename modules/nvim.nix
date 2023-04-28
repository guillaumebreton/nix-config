# nix module to install neovim
{ config, pkgs, ... }:
{
    xdg.configFile."nvim" = {
        source = ../config/nvim;
        target = "nvim";
    };

    programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
    };
   	programs.neovim.plugins = [
  pkgs.vimPlugins.nvim-tree-lua
  {
    plugin = pkgs.vimPlugins.vim-startify;
    config = "let g:startify_change_to_vcs_root = 0";
  }
];
}

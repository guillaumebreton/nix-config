# nix module to install neovim
{ config, pkgs, ... }:
{
    xdg.configFile."nvim" = {
        source = ../config/nvim;
        target = "nvim";
    };

    programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
    };
   	programs.neovim.plugins = [
        pkgs.vimPlugins.telescope-nvim
        (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [ p.c p.rust p.go p.javascript p.java ]))
        pkgs.vimPlugins.nightfox-nvim
        pkgs.vimPlugins.nvim-lspconfig
        pkgs.vimPlugins.nvim-cmp
    ];
}

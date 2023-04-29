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
   	programs.neovim.plugins = with pkgs.vimPlugins; [

        # fuzzy finding
        telescope-nvim

        # treesitter
        (nvim-treesitter.withPlugins (p: [ p.c p.rust p.go p.javascript p.java ]))

        # lsp
        nvim-lspconfig
        nvim-cmp
        cmp-buffer
        cmp-path
        cmp_luasnip
        cmp-nvim-lsp
        cmp-nvim-lua
        luasnip
        lsp-zero-nvim

        # icons
        nvim-web-devicons

        # colorschemes
        nightfox-nvim

    ];
}

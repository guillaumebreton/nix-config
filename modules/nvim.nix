# nix module to install neovim
{ config, pkgs, ... }:
{
    # add config
    xdg.configFile."nvim" = {
        source = ../config/nvim;
        target = "nvim";
    };

    # enable neovim
    programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
    };

    # install plugin
   	programs.neovim.plugins = with pkgs.vimPlugins; [

        # fuzzy finding
        telescope-nvim

        # treesitter
        (nvim-treesitter.withPlugins (p: [ p.c p.rust p.go p.javascript p.java p.nix p.lua p.elixir p.tsx ]))
        # Syntax aware text-objects, select, move, swap, and peek support
        nvim-treesitter-textobjects

        # Github copilot
        copilot-vim

        # vim tree lua
        nvim-tree-lua

        # lsp
        nvim-lspconfig
        nvim-cmp
        cmp-buffer
        cmp-path
        cmp-nvim-lsp
        cmp-nvim-lua
        lsp-zero-nvim

        # Comment
        nvim-comment

        # snippets
        friendly-snippets
        luasnip
        cmp_luasnip

        # icons
        nvim-web-devicons

        # colorschemes
        nightfox-nvim

        # error/issue display
        trouble-nvim
    ];
}

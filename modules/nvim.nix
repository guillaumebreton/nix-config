# nix module to install neovim
{ config, lib, pkgs, ... }:
let
  fromGitHub = rev: ref: repo: pkgs.vimUtils.buildVimPlugin {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
      rev = rev;
    };
  };
in {
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

        # # fuzzy finding
        # telescope-nvim

        # # treesitter
        # (nvim-treesitter.withPlugins (p: [ p.c p.rust p.go p.javascript p.java p.nix p.elixir p.tsx p.eex p.heex p.terraform p.html]))
        # # Syntax aware text-objects, select, move, swap, and peek support
        # nvim-treesitter-textobjects

        # # Github copilot
        # copilot-vim

        # # vim tree lua
        # nvim-tree-lua

        # # lsp
        # nvim-lspconfig
        # # nvim-cmp
        # cmp-buffer
        # cmp-path
        # cmp-nvim-lsp
        # cmp-nvim-lua
        # lsp-zero-nvim

        # # Comment
        # nvim-comment

        # # Smooth scroll
        # neoscroll-nvim

        # # snippets
        # friendly-snippets
        # luasnip
        # cmp_luasnip

        # # icons
        # nvim-web-devicons

        # colorschemes
        # nightfox-nvim
        tokyonight-nvim

        # # error/issue display
        # trouble-nvim

        # # conform formatting
        # conform-nvim

        # # linting
        # nvim-lint

        # # easy motion
        # (fromGitHub "48817af25f51c0590653bbc290866e4890fe1cbe" "main" "folke/flash.nvim")

    ];
}

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
    ];
}

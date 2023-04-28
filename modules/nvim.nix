# nix module to install neovim
{ config, pkgs, ... }:
{
    xdg.configFile."i3" = {
        source = ./config/nvim;
        target = "nvim";
    };
	home.packages = with pkgs; [
	    neovim
	];
}

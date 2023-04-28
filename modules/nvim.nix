# nix module to install neovim
{ config, pkgs, ... }:
{
    xdg.configFile."nvim" = {
        source = ../config/nvim;
        target = "nvim";
    };
	home.packages = with pkgs; [
	    neovim
		vimPlugins.packer-nvim
		telescope-fzf-native-nvim
		# vimPlugins.harpoon
		vimPlugins.plenary-nvim
	];
}

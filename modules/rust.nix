{ config, pkgs, ... }:
{
	home.packages = with pkgs; [
        rust-analyzer # rust language server
	];

}

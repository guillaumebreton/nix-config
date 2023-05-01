{ config, pkgs, ... }:
{
	home.packages = with pkgs; [
    sumneko-lua-language-server # lua language server
	];

}

{ config, pkgs, ... }:
{
	home.packages = with pkgs; [
		nodePackages.typescript-language-server # typescript language server
		nodePackages.eslint_d
        nodePackages.typescript-language-server
        nodePackages.typescript
		nodejs-16_x
	];
}

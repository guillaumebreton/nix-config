{ config, pkgs, ... }:
{
	home.packages = with pkgs; [
		nodePackages.typescript-language-server # typescript language server
		nodePackages.eslint_d
    nodePackages.typescript-language-server
    nodePackages.typescript
    nodePackages.pnpm
    nodePackages_latest.prettier
		nodejs
    cargo-tauri

	];
}

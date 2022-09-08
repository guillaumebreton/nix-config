{ config, pkgs, ... }:
let
	nigpkgsRev = "nixpkgs-unstable";
	pkgs = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${nigpkgsRev}.tar.gz") {};

	# Import other Nix files
	imports = [
		../common.nix
	];

in {

	inherit imports;

	# Home Manager needs a bit of information about you and the
	# paths it should manage.
	home.username = "guillaumebreton";
	home.homeDirectory = "/Users/guillaumebreton";


	programs.neovim = {
		enable = true;
	};

	home.packages = with pkgs; [
		bash # install bash 4 so zsh-nix-shell works correctly
		direnv
		rbenv
		bundler
		awscli2
	];
}

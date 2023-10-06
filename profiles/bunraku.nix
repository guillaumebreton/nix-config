{ config, pkgs, ... }:
let
	# nigpkgsRev = "nixpkgs-unstable";
	# pkgs = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${nigpkgsRev}.tar.gz") {};

	# Import other Nix files
	imports = [
		../modules/common.nix
		../modules/golang.nix
		../modules/rust.nix
    ../modules/elixir.nix
		../modules/typescript.nix
	];

in {

	inherit imports;

	# Home Manager needs a bit of information about you and the
	# paths it should manage.
	home.username = "guillaume";
	home.homeDirectory = "/Users/guillaume";

	home.packages = with pkgs; [
		direnv # Per-directory environment variables
		# pscale # the cli for pscale database
		yarn 	# yarn
		jo # jo is a JSON tool
		tokei # tokei is a tool to count lines of code
		jless # jless is a tool to display JSON
		bash
		flyctl
		postgresql
		nodejs

    mariadb
    tailwindcss


    # should be a separate package
    nodePackages.eslint_d
    nodePackages.typescript-language-server
    nodePackages.typescript
    nodePackages.vscode-langservers-extracted


    # TODO should be part of go
		gopls
		go

    google-cloud-sdk
    terraform

    typst
    d2

	];

}

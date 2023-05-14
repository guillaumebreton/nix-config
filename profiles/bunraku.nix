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
		nodejs-16_x
    nodePackages.eslint_d
    nodePackages.typescript-language-server
    nodePackages.typescript

		ledger
		hledger

        # TODO should be part of go
		gopls
		go

		# nodePackages.node-gyp-build
		# nodePackages.lerna # lerna is a package manager for Nix
		# nodejs # nodejs
		# temp dev
		# nodePackages.vercel
		# nodePackages.pnpm #Ultra fast npm alternative

		# nerves deployment
		# fwup
		# squashfsTools
		# coreutils-prefixed
		# xz
		# pkg-config

		# autoconf
		# automake
		# curl
		# erlangR24
		# fwup
		# pkgs.beam.packages.erlangR24.elixir
		# rebar3
		# squashfsTools
		# x11_ssh_askpass
		# zstd
	];

}

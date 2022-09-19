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
	home.username = "guillaume";
	home.homeDirectory = "/Users/guillaume";

	programs.neovim = {
		enable = true;
	};

	home.packages = with pkgs; [
		direnv # Per-directory environment variables
		nodePackages.pnpm #Ultra fast npm alternative
		pscale # the cli for pscale database
		nodePackages.vercel
		yarn 	# yarn
		# nodePackages.node-gyp-build
		# nodePackages.lerna # lerna is a package manager for Nix
		nodejs # nodejs
		jo # jo is a JSON tool
		tokei # tokei is a tool to count lines of code
		jless # jless is a tool to display JSON
		bash
		nodePackages.node-gyp-build


		# nerves deployment
		fwup
		squashfsTools
		coreutils-prefixed
		xz
		pkg-config

		autoconf
		automake
		curl
		erlangR24
		fwup
		pkgs.beam.packages.erlangR24.elixir
		rebar3
		squashfsTools
		x11_ssh_askpass
		zstd

		postgresql
		# temporary
		flyctl

	];

}

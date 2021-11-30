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
    	erlang # OTP with weird syntax
		elixir # OTP with cool syntax
		nodePackages.pnpm #Ultra fast npm alternative
		flyctl # command line for fly.io
		pscale # the cli for pscale database
		mysql # my sql command line
		nodePackages.vercel
		yarn 	# yarn
		nodePackages.lerna # lerna is a package manager for Nix
		nodejs # nodejs

	];

}

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

}

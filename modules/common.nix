{ config, pkgs, mkIf, lib,... }:
let
	# nigpkgsRev = "nixpkgs-unstable";
	# pkgs = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${nigpkgsRev}.tar.gz") {};

	# Import other Nix files
	imports = [
	   ./alacritty.nix
		./git.nix
		./shell.nix
		./starship.nix
		./tmux.nix
		./nvim.nix
        ./lua.nix
	];

	gitTools = with pkgs.gitAndTools; [
		delta
		diff-so-fancy
	];

in {

	inherit imports;
	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;

	home.stateVersion = "23.11";

	nixpkgs.config = {
		allowUnfree = true;
		allowUnsupportedSystem = true;
	};

	home.sessionVariables = {
		EDITOR = "vi";
		# TERMINAL = "alacritty";
	};




	home.packages = with pkgs; [
		bat # Replacement for cat
		curl # good old curl
		fd # Replacement for finx d
		(lib.lowPrio fzf) # fuzzy finder
		jq # JSON faster
		ripgrep # Replacement for grep
		(lib.lowPrio starship) # Fancy shell that works with zsh
		trash-cli # a replacement for rm
		ouch # zip, tar replacement
		coreutils # The best unix utilities
		dateutils # Date utilities
		nnn # file explorer
    gh # github cli
    pscale  # pscale cli
    # golang linter

	] ++ gitTools ;

}

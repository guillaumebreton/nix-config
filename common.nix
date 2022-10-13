{ config, pkgs, ... }:
let
	nigpkgsRev = "nixpkgs-unstable";
	pkgs = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${nigpkgsRev}.tar.gz") {};

	# Import other Nix files
	imports = [
		./modules/alacritty.nix
		./modules/git.nix
		./modules/shell.nix
		./modules/starship.nix
		./modules/tmux.nix
		./modules/neovim.nix
		./modules/helix.nix
		./modules/taskwarrior.nix
	];

	gitTools = with pkgs.gitAndTools; [
		delta
		diff-so-fancy
	];

in {

	inherit imports;
	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;

	home.stateVersion = "21.11";

	nixpkgs.config = {
		allowUnfree = true;
		allowUnsupportedSystem = true;
	};

	home.sessionVariables = {
		EDITOR = "helix";
		TERMINAL = "alacritty";
	};


	# programs.go.enable = true;
	home.packages = with pkgs; [
		bat # Replacement for cat
		curl # good old curl
		go # The famous golang language
		exa # Replacement for lds
		fd # Replacement for finx d
		(lib.lowPrio fzf) # fuzzy finder
		jq # JSON faster
		ripgrep # Replacement for grep
		(lib.lowPrio starship) # Fancy shell that works with zsh
		trash-cli # a replacement for rm
		ouch # zip, tar replacement
		coreutils # The best unix utilities
		dateutils # Date utilities
		taskwarrior # Task management tooling
		helix # Awesome editor to replace nvim
		nnn # file explorer
		
		# language server
		gopls # Golang language server
		delve # Golang debugger
	] ++ gitTools ;

}

{ config, pkgs, ... }:
let
	nigpkgsRev = "nixpkgs-unstable";
	pkgs = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${nigpkgsRev}.tar.gz") {};

	# Import other Nix files
	imports = [
		./alacritty.nix
		./git.nix
		./shell.nix
		./starship.nix
		./tmux.nix
		./neovim.nix
	];

	gitTools = with pkgs.gitAndTools; [
		delta
		diff-so-fancy
		gh
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
		EDITOR = "nvim";
		TERMINAL = "alacritty";
	};

	programs.go.enable = true;

	home.packages = with pkgs; [
		bat # Replacement for cat
		curl # good old curl
		direnv # Per-directory environment variables
		elixir # OTP with cool syntax
    	erlang # OTP with weird syntax
		go # The famous golang language
		exa # Replacement for lds
		fd # Replacement for find
		fzf # fuzzy finder
		jq # JSON faster
		nodejs-16_x # Runtime for frontent app and tools
		nodePackages.pnpm #Ultra fast npm alternative
		postgresql_13 # The best database on earth
		ripgrep # Replacement for grep
		starship # Fancy shell that works with zsh
		trash-cli # a replacement for rm
		flyctl # command line for fly.io

	] ++ gitTools ;

}
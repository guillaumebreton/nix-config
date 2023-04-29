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
		./helix.nix
		./nvim.nix
	];

	gitTools = with pkgs.gitAndTools; [
		delta
		diff-so-fancy
	];

in {

	inherit imports;
	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;

	home.stateVersion = "22.05";

	nixpkgs.config = {
		allowUnfree = true;
		allowUnsupportedSystem = true;
	};

	home.sessionVariables = {
		EDITOR = "vi";
		TERMINAL = "alacritty";
	};

	home.activation =  {
      copyApplications = let
        apps = pkgs.buildEnv {
          name = "home-manager-applications";
          paths = config.home.packages;
          pathsToLink = "/Applications";
        };
      in lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        baseDir="$HOME/Applications/Home Manager Apps"
        if [ -d "$baseDir" ]; then
          rm -rf "$baseDir"
        fi
        mkdir -p "$baseDir"
        for appFile in ${apps}/Applications/*; do
          target="$baseDir/$(basename "$appFile")"
          $DRY_RUN_CMD cp ''${VERBOSE_ARG:+-v} -fHRL "$appFile" "$baseDir"
          $DRY_RUN_CMD chmod ''${VERBOSE_ARG:+-v} -R +w "$target"
        done
      '';
    };


	home.packages = with pkgs; [
		bat # Replacement for cat
		curl # good old curl
		exa # Replacement for ls
		fd # Replacement for finx d
		(lib.lowPrio fzf) # fuzzy finder
		jq # JSON faster
		ripgrep # Replacement for grep
		(lib.lowPrio starship) # Fancy shell that works with zsh
		trash-cli # a replacement for rm
		ouch # zip, tar replacement
		coreutils # The best unix utilities
		dateutils # Date utilities
		helix # Awesome editor to replace nvim
		nnn # file explorer

	] ++ gitTools ;

}

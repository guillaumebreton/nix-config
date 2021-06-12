{ config, pkgs, ... }:
let
  nigpkgsRev = "nixpkgs-unstable";
  pkgs = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${nigpkgsRev}.tar.gz") {};

  # Import other Nix files
  imports = [
    ./alacritty.nix
    ./shell.nix
    ./neovim.nix
    ./starship.nix
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

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "guillaume";
  home.homeDirectory = "/Users/guillaume";

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
	  direnv # Per-directory environment variables
	  exa # Replacement for lds
	  fd # Replacement for find
	  ripgrep # Replacement for grep
	  starship # Fancy shell that works with zsh
	  fira-code
  ] ++ gitTools ;


  home.activation = {
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

}

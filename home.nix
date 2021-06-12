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
	  trash-cli # a replacement for rm
  ] ++ gitTools ;

}

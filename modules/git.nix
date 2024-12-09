# Git settings

{  pkgs, ... }:

let
	vscode = pkgs.vscode;
in {
	programs.git = {
		package = pkgs.gitAndTools.gitFull;
		enable = true;
		userName = "Guillaume Breton";
		userEmail = "breton.gy@gmail.com";

		# Replaces ~/.gitignore
		ignores = [
			".cache/"
			".DS_Store"
			".idea/"
			"*.swp"
			"built-in-stubs.jar"
			"dumb.rdb"
			".elixir_ls/"
			".vscode/"
			"npm-debug.log"
		];

		# Replaces aliases in ~/.gitconfig
		aliases = {
			lg = "log --graph -20 --pretty=format:'%C(yellow)%h%Cred%d%Creset - %C(bold blue)%an %Creset: %s %Cgreen(%cr)' --abbrev-commit --date=relative";
			l = "log --pretty=format:'%C(yellow)%h%Cred%d%Creset - %C(bold blue)%an %Creset: %s %Cgreen(%cr)'";
			ll = "log --pretty=format:'%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]' --decorate --numstat";
			st = "status --short";
		};

		# Global Git config
		extraConfig = {
			core = {
			editor = "vi";
			pager = "delta --dark";
			whitespace = "trailing-space,space-before-tab";
			};
			push = {
				default = "current";
				followTags = "true";
			};
			branch = {
				autosetuprebase = "always";
			};
			rebase = {
				autosquash = "true";
			};
		};
	};
}

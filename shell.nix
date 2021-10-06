# Shell configuration for zsh (frequently used) and fish (used just for fun)

{ config, lib, pkgs, ... }:

let
	# Set all shell aliases programatically
	shellAliases = {
		# Aliases for commonly used tools
		grep = "rg";
		diff = "diff --color=auto";
		cat = "bat";
		find = "fd";
		l = "exa";
		ll = "ls -lh";
		ls = "exa";
		tree="ls -T";
		rm="trash";

		# git aliases
		gs="git switch";
		gr="git restore";
		gst="git status";
		gcm="git commit -m ";
		gca="git commit --amend ";
		gp="git push";
		grh="git reset --hard head";
		gri="git rebase -i";
		gcapf="git add --all && gca && gpf";
		gaa="git add --all";
		gc ="git commit";
		gco="git checkout";
		gcp="git add --all && gc && gp";
		grc="git rebase --continue";
		pr="gh pr create ";
		gpf="git push --force-with-lease";

		# go aliases
		got="go test ./...";
		goi="go install .";
		gor="go run .";
		gob="go build .";

		# tmux aliases
		dev="cd ~/Workspaces && tmux";

		# Reload zsh
		reload = "source ~/.zshrc";

		# Reload home manager and zsh
		switch = "home-manager switch && source ~/.zshrc";

		# Nix garbage collection
		garbage = "nix-collect-garbage -d && docker image prune --force";

		# See which Nix packages are installed
		installed = "nix-env --query --installed";

		# Flycl
		fly = "flyctl";

		# Nix-shell
		ns = "nix-shell";
	};
in {

	programs.fzf = {
	 enable = true;
	 enableBashIntegration = true;
	 defaultCommand = "${pkgs.ripgrep}/bin/rg --no-messages --files --hidden --follow --glob '!.git/*'";
	};

	# zsh settings
	programs.zsh = {
		inherit shellAliases;
		enable = true;
		enableAutosuggestions = true;
		enableCompletion = true;
		history.extended = true;

		# Called whenever zsh is initialized
		initExtra = ''
			export TERM="xterm-256color"
			bindkey -e

			# Nix setup (environment variables, etc.)
			if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
				. ~/.nix-profile/etc/profile.d/nix.sh
			fi

			# Load environment variables from a file;
			if [ -e ~/.extras ]; then
				. ~/.extras
			 fi

			# Start up Starship shell
			eval "$(starship init zsh)"

			# Autocomplete for various utilities
			source <(gh completion --shell zsh)

			# direnv setup
			eval "$(direnv hook zsh)"

			# direnv hook
			eval "$(direnv hook zsh)"
		'';
		plugins = [
			{
				name = "zsh-nix-shell";
				file = "nix-shell.plugin.zsh";
				src = pkgs.fetchFromGitHub {
				owner = "chisui";
				repo = "zsh-nix-shell";
				rev = "v0.4.0";
				sha256 = "037wz9fqmx0ngcwl9az55fgkipb745rymznxnssr3rx9irb6apzg";
				};
			}
		];
	};
}

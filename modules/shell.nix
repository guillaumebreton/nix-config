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
		ls = "ls -lh";
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
		gpf="git push --force-with-lease";

    # github pr
    gpr="gh pr view --web || gh pr create -f -w -B main -H ` git rev-parse --abbrev-ref HEAD`";


		# go aliases
		got="go test ./...";
		goi="go install .";
		gor="go run .";
		gob="go build .";

		# Reload zsh
		reload = "source ~/.zshrc";

		# Reload home manager and zsh
		# until https://github.com/nix-community/home-manager/issues/2848 is fixed
		# switch = "home-manager switch && source ~/.zshrc";
		switch = "nix profile list | { grep 'home-manager-path$' || test $? = 1; } | awk -F ' ' '{ print $4 }' | cut -d ' ' -f 4 | xargs -t $DRY_RUN_CMD nix profile remove $VERBOSE_ARG &&  nix build --no-link ~/Workspaces/nix-config#homeConfigurations.$(hostname -s).activationPackage && \"$(nix path-info ~/Workspaces/nix-config#homeConfigurations.$(hostname -s).activationPackage)\"/activate && source ~/.zshrc";

		# Nix garbage collection
		garbage = "nix-collect-garbage -d && docker image prune --force";

		# See which Nix packages are installed
		installed = "nix-env --query --installed";

		# Flycl
		fly = "flyctl";

		# Nix-shell
		ns = "nix-shell shell.nix";

		# task
		t= "task ls";
		tw="task week";
		tm="task tomorrow";
		tl="task list";
		tsa="tsa() {task $1 mod seg:A};tsa";
		tsm="tsm() {task $1 mod seg:M};tsm";
		tse="tse() {task $1 mod seg:E};tse";
		te="te() {task $1 edit};te";
		td="td() {task $1 mod sched:today};td";
		tn="tn() {task $1 mod +next};tn";
		ts="ts() {task $1 start};ts";
		tt="tt() {task $1 mod sched:$2};tt";


		# nnn
		n="nnn";
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

			# direnv setup
			eval "$(direnv hook zsh)"

      # start devlopement enviroment
      ved(){
          # If no argument is given, list all the workspaces
          selected=$1
          if [ -z $1 ]; then
              selected=`ls ~/Workspaces/ | fzf`
          fi
          # ctrl-c pressed
          if [ -z $selected ]; then
              return 0
          fi

          WORKING_DIRECTORY=$(cdpath=(. ~/Workspaces) cd $selected > /dev/null 2>&1 && pwd)
          echo "working directory: $WORKING_DIRECTORY"

          # Switch session
          session_name=`echo $selected | sed 's/\./_/g'`
          if [ -z "$TMUX" ]; then
              tmux new-session -As $session_name -c $WORKING_DIRECTORY
          else
              if ! tmux has-session -t $session_name 2>/dev/null; then
                  TMUX= tmux new-session -ds $session_name -c $WORKING_DIRECTORY
              fi
              echo "switching to $session_name session"
              tmux switch-client -t $session_name
          fi
      }


			tad(){
				hour=`date +%H`
				if [[ $hour -lt 12 ]]
				then
					task add $@ sched:today seg:M
				elif [[ $hour -lt 18 ]]
				then
					task add $@ sched:today seg:A
				else
					task add $@ sched:today seg:E
				fi
			}

			tp(){
				task $@ mod due: sched:tomorrow
			}
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

# tmux settings

{ config, lib, pkgs, ... }:

{
	programs.tmux = {
		enable = true;
		escapeTime = 0;
		baseIndex = 1;
		keyMode = "vi";
		shortcut = "b";

		# Replaces ~/.tmux.conf
		extraConfig = ''
			set-option -g mouse on
			set-option -g default-shell ''${SHELL}

		set -g history-limit 10000

		# start window index at 1
		set -g base-index 1

		# start pane index at 1
		setw -g pane-base-index 1

		# highlight window when it has new activity
		setw -g monitor-activity on
		set -g visual-activity on

		set -g renumber-windows on

		set -g set-clipboard on

		setw -g mode-keys vi
		setw -g status-keys vi

			bind Escape copy-mode

			bind | split-window -h -c "#{pane_current_path}"
			bind _ split-window -v -c "#{pane_current_path}"
			bind c new-window -c "#{pane_current_path}"

			bind h select-pane -L
			bind j select-pane -D
			bind k select-pane -U
			bind l select-pane -R

			bind-key J resize-pane -D 5
			bind-key K resize-pane -U 5
			bind-key H resize-pane -L 5
			bind-key L resize-pane -R 5

			bind N previous-window

		bind q confirm-before -p "kill-window #W? (y/n)" kill-window
		bind C-n next-window

		# bind key for synchronizing panes
		bind-key y set-window-option synchronize-panes


	# set refresh interval for status bar
	set -g status-interval 30

	# center the status bar
	set -g status-justify left
	set-option -g status-position top


	# show session, window, pane in left status bar
	set -g status-left-length 40
	set-option -g status-interval 5
	set -g status-left '#[default]'

	# show hostname, date, time, and battery in right status bar
	set-option -g status-right '%m/%d/%y %I:%M\
	#[fg=red]#(battery discharging)#[default]#(battery charging)'



	###########################
	# Colors
	###########################

	# color status bar
	set -g status-style bg=black,fg=white
	set -g status-left-style bg=black,fg=white

	# highlight current window
	set -g window-status-style bg=black,fg=white
	set -g window-status-current-style bg=black,fg=green

	# set color of active pane
	set -g pane-active-border-style bg=black,fg=green
	set -g pane-border-style bg=black,fg=black

	set-option -g allow-rename off
		'';
	};
}

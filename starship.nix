# Starship configuration

{ config, lib, pkgs, ... }:

{
	programs.starship = {
		enable = true;
	enableZshIntegration = true;

		# Configuration written to ~/.config/starship.toml
		settings = {
			add_newline = true;

			character = {
				success_symbol = "[➜](bold green) ";
				error_symbol = "[✗](bold red) ";
		};
			gcloud.disabled = true;
		aws.disabled= true;
		};
	};
}

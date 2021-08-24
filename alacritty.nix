# Starship configuration

{ config, lib, pkgs, ... }:

{
	programs.alacritty = {
	enable = true;
	settings = {
		env = {
			"TERM" = "xterm-256color";
		};
		window = {
			padding.x = 10;
			padding.y = 10;
		};
		font = {
			size = 12.0;
			use_thin_strokes = true;
			normal.family = "Fira code nerd font";
			bold.family = "Fira code nerd font";
		};
	cursor.style = "Beam";
	};
  };
}

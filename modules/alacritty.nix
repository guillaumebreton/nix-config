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
			# use_thin_strokes = true;
			normal.family = "Berkeley Mono";
			bold.family = "Berkeley Mono";
		};
		cursor.style = "Beam";
		scrolling = {
			history = 10000;
		};
	};
  };
}

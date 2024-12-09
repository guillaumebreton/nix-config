{ config, lib, pkgs, ... }:

{
	programs.alacritty = {
	enable = true;
	settings = {
		env = {
			"TERM" = "xterm-256color";
		};
		window = {
			padding.x = 5;
			padding.y = 5;
			title = "bunraku";
		};
		font = {
			size = 13.0;
            offset = {
                y = 3;
            };
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

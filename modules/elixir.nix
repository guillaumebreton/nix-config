{ config, pkgs, ... }:
{
	# programs.go.enable = true;
	home.packages = with pkgs; [
		elixir 
		elixir_ls 
    erlang
    fly
	];
}

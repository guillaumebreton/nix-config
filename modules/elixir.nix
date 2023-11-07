{ config, pkgs, ... }:
{
	# programs.go.enable = true;
	home.packages = with pkgs; [
    elixir_1_15
		elixir_ls 
    erlang
	];
}

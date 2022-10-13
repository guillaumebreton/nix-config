{ config, pkgs, ... }:
{
	# programs.go.enable = true;
	home.packages = with pkgs; [
		# language server
		gopls # Golang language server
		delve # Golang debugger
	];

}

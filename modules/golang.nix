{ config, pkgs, ... }:
{
	# programs.go.enable = true;
	home.packages = with pkgs; [
		gopls # Golang language server
		delve # Golang debugger
    golangci-lint

    sqlc

	];
}

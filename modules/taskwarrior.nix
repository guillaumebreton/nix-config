{ config, lib, pkgs, ... }:

{
    # Write the files
	home.file.".taskrc".source = ../config/.taskrc;
	home.file.".task.theme".source = ../config/.task.theme;
}


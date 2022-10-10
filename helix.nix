{ config, lib, pkgs, ... }:

{
    xdg.configFile."helix/config.toml".source = ./config/helix.toml;
}

# Expose home-manager modules for reuse in other configs (e.g. work machine)
{ ... }:
{
  flake.homeModules = {
    common = ../modules/common.nix;
  };
}

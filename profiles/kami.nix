# Host profile: kami (aarch64-darwin)

{ ... }:

{
  imports = [ ../modules/common.nix ];

  home.username = "guillaume";
  home.homeDirectory = "/Users/guillaume";
}

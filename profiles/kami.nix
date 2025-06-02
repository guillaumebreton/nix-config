{ pkgs,  ... }:
let
  # Import other Nix files
  imports = [ ../modules/common.nix ];

in {

  inherit imports;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "guillaume";
  home.homeDirectory = "/Users/guillaume";

  home.packages = with pkgs; [
    # ghostty.packages."aarch64-linux".default
    zed-editor
    # diagram tooling
    d2
    nmap
    tailscale
    jujutsu

  ];
}

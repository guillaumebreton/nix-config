# nh - Nix Helper: better rebuild UX with package diffs and auto GC

{ ... }:

{
  programs.nh = {
    enable = true;
    flake = "/Users/guillaume/Workspaces/nix-config";

    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 5 --keep-since 14d";
    };
  };
}

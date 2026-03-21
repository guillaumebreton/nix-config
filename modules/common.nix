# Entry point: imports all home-manager modules

{ ... }:

{
  imports = [
    ./git.nix
    ./ghostty.nix
    ./lang-go.nix
    ./lang-python.nix
    ./lang-typescript.nix
    ./nh.nix
    ./nvim.nix
    ./packages.nix
    ./pi-agent.nix
    ./session.nix
    ./shell.nix
    ./starship.nix
    ./tmux.nix
  ];

  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}

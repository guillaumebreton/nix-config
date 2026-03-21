# Python development tools

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    python3
    pipx # install python apps in isolated envs
    ruff # linter + formatter
    uv # fast package manager
  ];
}

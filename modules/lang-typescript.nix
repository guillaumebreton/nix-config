# TypeScript / Node.js development tools

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs
    bun # fast JS runtime + package manager
    yarn
    nodePackages.pnpm
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted # html/css/json/eslint LSPs
    nodePackages.eslint_d
    nodePackages_latest.prettier
    cargo-tauri # desktop app framework
  ];
}

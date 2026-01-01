{ pkgs, lib, ... }:
let
  # Import other Nix files
  imports = [
    ./git.nix
    ./shell.nix
    ./starship.nix
    ./tmux.nix
    ./nvim.nix
    ./ghostty.nix
    ./taskwarrior.nix
  ];

in
{

  inherit imports;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "23.11";

  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };

  home.sessionVariables = {
    EDITOR = "vi";
    TERMINAL = "ghotty";

  };

  home.packages = with pkgs; [
    # TOOLING
    bat # Replacement for cat
    curl # good old curl
    (lib.lowPrio fzf) # fuzzy finder
    jq # JSON faster
    (lib.lowPrio starship) # Fancy shell that works with zsh
    trash-cli # a replacement for rm
    ouch # zip, tar replacement
    coreutils # The best unix utilities
    dateutils # Date utilities

    # UTILS
    delta
    wget
    direnv
    gh # github cli
    jless # jless is a tool to display JSON
    ripgrep # Replacement for grep
    fd # Replacement for finx d

    # GOLANG
    gopls # Golang language server
    delve # Golang debugger
    golangci-lint
    go

    # PYTHON
    python3
    pipx
    ruff
    uv

    # Elixir
    elixir

    # TYPESCRIPT
    nodePackages.typescript
    nodePackages.vscode-langservers-extracted
    nodePackages.typescript-language-server # typescript language server
    nodePackages.eslint_d
    nodePackages.pnpm
    nodePackages_latest.prettier
    nodejs
    yarn
    bun
    cargo-tauri

    # NIX
    nixd
    nil
    nixfmt-classic

    # database tooling
    postgresql
    sqlc
    goose
    sqlc

    # virtualization
    podman
    kubectl
    kubectx

    # Network
    cloudflared

    # AI
    claude-code

  ];

}

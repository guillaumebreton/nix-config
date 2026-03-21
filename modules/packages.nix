# Home packages

{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # TOOLING
    bat # Replacement for cat
    curl # good old curl
    (lib.lowPrio fzf) # fuzzy finder
    jq # JSON processor
    (lib.lowPrio starship) # Fancy shell prompt
    trash-cli # safer rm replacement
    ouch # zip/tar replacement
    coreutils # Unix utilities
    dateutils # Date utilities

    # UTILS
    delta
    wget
    direnv
    gh # GitHub CLI
    jless # JSON viewer
    ripgrep # Replacement for grep
    fd # Replacement for find

    # GOLANG
    gopls # Golang language server
    delve # Golang debugger
    golangci-lint
    air # Live reload for Go apps
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
    nodePackages.typescript-language-server
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

    # DATABASE
    postgresql
    sqlc
    goose

    # VIRTUALIZATION
    podman
    kubectl
    kubectx

    # NETWORK
    cloudflared

    # AI
    claude-code
    opencode

    # MISC
    playwright
    zed-editor
    d2
    nmap
    jujutsu
  ];
}

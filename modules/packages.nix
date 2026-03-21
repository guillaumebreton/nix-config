# Core home packages (language tooling lives in lang-*.nix)

{
  pkgs,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    # SHELL TOOLING
    bat # replacement for cat
    curl
    (lib.lowPrio fzf) # fuzzy finder
    jq # JSON processor
    (lib.lowPrio starship) # shell prompt
    trash-cli # safer rm
    ouch # zip/tar replacement
    coreutils
    dateutils

    # UTILS
    delta # better diffs
    wget
    direnv
    gh # GitHub CLI
    jless # JSON viewer
    ripgrep # replacement for grep
    fd # replacement for find

    # NIX
    nixd # Nix language server
    nil # Nix language server (alternative)
    nixfmt # Nix formatter

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
    elixir
    playwright
    zed-editor
    d2
    nmap
    jujutsu
  ];
}

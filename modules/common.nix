{  pkgs, lib, ... }:
let
  # Import other Nix files
  imports = [
    ./git.nix
    ./shell.nix
    ./starship.nix
    ./tmux.nix
    ./nvim.nix
    ./ghostty.nix
  ];

  gitTools = with pkgs.gitAndTools; [ delta diff-so-fancy ];

in {

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
    # TERMINAL = "alacritty";
  };

  home.packages = with pkgs;
    [
      # TOOLING
      bat # Replacement for cat
      curl # good old curl
      fd # Replacement for finx d
      (lib.lowPrio fzf) # fuzzy finder
      jq # JSON faster
      ripgrep # Replacement for grep
      (lib.lowPrio starship) # Fancy shell that works with zsh
      trash-cli # a replacement for rm
      ouch # zip, tar replacement
      coreutils # The best unix utilities
      dateutils # Date utilities
      nnn # file explorer
      gh # github cli
      jo # jo is a JSON tool
      tokei # tokei is a tool to count lines of code
      jless # jless is a tool to display JSON
      direnv # Per-directory environment variables

      # GOLANG
      gopls # Golang language server
      delve # Golang debugger
      golangci-lint
      gopls
      go
      tinygo

      # PYTHON
      python3
      pipx
      ruff

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

      # taskwarrior
      taskwarrior3

    ] ++ gitTools;

}

# Pi coding agent configuration
# - skills/ (repo root)       → ~/.agents/skills/   (pi reads this automatically)
# - config/pi/themes/         → ~/.pi/agent/themes/
# - config/pi/prompts/        → ~/.pi/agent/prompts/
# - settings.json             → ~/.pi/agent/settings.json (read-only; pi can't persist runtime state)

{ ... }:

{
  # Settings — declaratively managed
  # Note: because this is a symlink to the nix store, pi cannot write back to it.
  # Changes made via /model, /settings etc. won't persist — update this file instead.
  home.file.".pi/agent/settings.json".text = builtins.toJSON {
    defaultProvider = "anthropic";
    defaultModel = "claude-sonnet-4-6";
    defaultThinkingLevel = "medium";
    theme = "tokyonight";
  };

  # Skills — auto-discovered by pi from ~/.agents/skills/
  # Add a directory under skills/ in the repo, it appears here on next switch
  home.file.".agents/skills" = {
    source = ../skills;
    recursive = true;
  };

  # Theme
  home.file.".pi/agent/themes/tokyonight.json".source = ../config/pi/themes/tokyonight.json;

  # Prompt templates — invoked via /review, /commit, /refactor
  home.file.".pi/agent/prompts" = {
    source = ../config/pi/prompts;
    recursive = true;
  };
}

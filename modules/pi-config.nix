# Pi coding agent configuration
# - skills/ (repo root)       → ~/.agents/skills/   (pi reads this automatically)
# - config/pi/themes/         → ~/.pi/agent/themes/
# - config/pi/prompts/        → ~/.pi/agent/prompts/
# - config/pi/AGENTS.md       → ~/.pi/agent/AGENTS.md

{ ... }:

{
  # Skills — auto-discovered by pi from ~/.agents/skills/
  # Add a directory under skills/ in the repo, it appears here on next switch
  home.file.".agents/skills" = {
    source = ../skills;
    recursive = true;
  };

  # Theme
  home.file.".pi/agent/themes/tokyonight.json".source = ../config/pi/themes/tokyonight.json;

  # Global context — loaded at every pi startup
  home.file.".pi/agent/AGENTS.md".source = ../config/pi/AGENTS.md;

  # Prompt templates — invoked via /review, /commit, /refactor
  home.file.".pi/agent/prompts" = {
    source = ../config/pi/prompts;
    recursive = true;
  };
}

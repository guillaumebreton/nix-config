# Pi coding agent configuration: global context, skills, and prompt templates
# Files are symlinked into ~/.pi/agent/ on every `switch`

{ ... }:

{
  # Global context — loaded at every pi startup
  home.file.".pi/agent/AGENTS.md".source = ../pi/AGENTS.md;

  # Skills — auto-loaded or invoked via /skill:name
  home.file.".pi/agent/skills/git-workflow/SKILL.md".source = ../pi/skills/git-workflow/SKILL.md;
  home.file.".pi/agent/skills/nix/SKILL.md".source = ../pi/skills/nix/SKILL.md;

  # Prompt templates — invoked via /review, /commit, /refactor
  home.file.".pi/agent/prompts/review.md".source = ../pi/prompts/review.md;
  home.file.".pi/agent/prompts/commit.md".source = ../pi/prompts/commit.md;
  home.file.".pi/agent/prompts/refactor.md".source = ../pi/prompts/refactor.md;
}

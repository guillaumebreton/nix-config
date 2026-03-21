---
description: Write a commit message for staged changes
---
Look at the staged changes (`git diff --cached`) and write a commit message.

Rules:
- Imperative mood, lowercase, no period
- Format: `type: short description` (max 72 chars)
- Types: `feat`, `fix`, `refactor`, `docs`, `chore`, `test`
- If the change is complex, add a blank line then a short body

Only output the commit message, nothing else. Then ask if I want to commit.

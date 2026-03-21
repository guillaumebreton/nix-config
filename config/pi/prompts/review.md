---
description: Review staged or recent changes for bugs, issues, and improvements
---
Review the staged changes (`git diff --cached`). If nothing is staged, review the last commit (`git diff HEAD~1`).

Look for:
- Logic errors and edge cases
- Missing error handling
- Security issues (injection, unvalidated input, exposed secrets)
- Performance problems
- Missing or insufficient tests

Be concise. Group findings by severity: critical, warning, suggestion.

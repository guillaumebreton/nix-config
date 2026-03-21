---
name: git-workflow
description: Git workflow helper. Use when committing, creating PRs, reviewing diffs, writing commit messages, or managing branches.
---

# Git Workflow

## Commit

1. Run `git diff --staged` to review what's staged
2. If nothing staged, run `git diff` and ask which changes to include
3. Write a commit message: imperative mood, lowercase, `type: short description`
   - Types: `feat`, `fix`, `refactor`, `docs`, `chore`, `test`
   - Example: `feat: add user authentication`
4. Run `git commit -m "<message>"`

## Pull Request

1. Run `git log main..HEAD --oneline` to summarise the branch
2. Run `git diff main...HEAD` to review all changes
3. Use `gh pr create` with a clear title and body listing what changed and why
4. Title follows the same convention as commit messages

## Branch

- Feature branches: `feat/short-description`
- Fix branches: `fix/short-description`
- Always branch from `main`: `git switch main && git pull && git switch -c feat/name`

## Code Review (incoming PR)

1. Run `gh pr checkout <number>`
2. Run `git diff main...HEAD` to see all changes
3. Look for: logic errors, missing error handling, security issues, missing tests
4. Leave comments with `gh pr review`

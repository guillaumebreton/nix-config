---
name: nix
description: Nix and home-manager helper. Use when editing the nix-config, adding packages, creating modules, upgrading inputs, or debugging Nix evaluation errors.
---

# Nix / Home-Manager

## Config location

`~/Workspaces/nix-config` — managed with home-manager + flake-parts.

```
flake.nix                  # inputs only
flake/
  systems.nix              # aarch64-darwin
  home-manager.nix         # homeConfigurations.kami
  treefmt.nix              # nix fmt (nixfmt)
profiles/
  kami.nix                 # username + homeDirectory
modules/
  common.nix               # import hub
  packages.nix             # core home.packages
  session.nix              # env vars
  git.nix                  # git config + aliases
  shell.nix                # zsh + aliases
  lang-go.nix              # Go tools + aliases
  lang-python.nix          # Python tools
  lang-typescript.nix      # TS/Node tools
  nh.nix                   # nix helper
  pi-agent.nix             # pi binary (buildNpmPackage)
  pi-config.nix            # pi skills/prompts/AGENTS.md
  tmux.nix / nvim.nix / ghostty.nix / starship.nix
pi/
  AGENTS.md                # global pi context
  skills/                  # pi skills
  prompts/                 # pi prompt templates
```

## Add a package

Add to the appropriate `modules/lang-*.nix` or `modules/packages.nix`:

```nix
home.packages = with pkgs; [ new-package ];
```

Then run `switch`.

## Add a module

1. Create `modules/my-module.nix`
2. Add it to `modules/common.nix` imports
3. Run `switch`

## Rebuild

```bash
switch          # nh home switch — shows diff, asks confirmation
nix fmt         # format all .nix files
nix flake update  # update all inputs
```

## Upgrade a package built with buildNpmPackage (e.g. pi)

1. Check latest version: `curl -s https://registry.npmjs.org/@scope/pkg/latest | jq .version`
2. Update version + URL in the module
3. Compute new hash: `nix-prefetch-url --unpack <tarball-url>` then `nix hash to-sri --type sha256 <hash>`
4. Regenerate package-lock.json: download tarball, run `npm install --package-lock-only`
5. Compute npmDepsHash: `prefetch-npm-deps package-lock.json`
6. Run `switch` to build and activate

## Debug evaluation errors

```bash
home-manager switch --flake .#kami --show-trace
```

# nix-config

Home Manager configuration for macOS (aarch64-darwin).

## Structure

```
nix-config/
├── flake.nix                  # Inputs only — outputs delegated to flake-parts
├── flake/                     # Flake-level wiring (auto-imported by import-tree)
│   ├── systems.nix            # Supported systems
│   ├── home-manager.nix       # homeConfigurations output (one entry per host)
│   └── treefmt.nix            # nix fmt formatter (nixfmt)
├── profiles/
│   └── kami.nix               # Host definition (username, homeDirectory)
├── modules/                   # Home-manager modules
│   ├── common.nix             # Import hub
│   ├── git.nix                # Git
│   ├── ghostty.nix            # Ghostty terminal
│   ├── lang-go.nix            # Go toolchain
│   ├── lang-python.nix        # Python toolchain
│   ├── lang-typescript.nix    # TypeScript / Node.js toolchain
│   ├── nh.nix                 # Nix Helper: rebuild UX + auto GC
│   ├── nvim.nix               # Neovim
│   ├── packages.nix           # Core packages (non-language)
│   ├── pi-agent.nix           # pi binary (buildNpmPackage)
│   ├── pi-config.nix          # pi skills, theme, prompts, AGENTS.md
│   ├── session.nix            # Session variables, nixpkgs config
│   ├── shell.nix              # Zsh, fzf, aliases
│   ├── starship.nix           # Starship prompt
│   └── tmux.nix               # Tmux
├── skills/                    # Pi skills → ~/.agents/skills/ (auto-discovered)
│   ├── git-workflow/SKILL.md
│   └── nix/SKILL.md
└── config/                    # App config assets
    ├── ghostty                # Ghostty config
    ├── nvim/                  # Neovim config
    └── pi/                    # Pi config assets
        ├── AGENTS.md          # → ~/.pi/agent/AGENTS.md
        ├── themes/
        │   └── tokyonight.json # → ~/.pi/agent/themes/tokyonight.json
        └── prompts/
            ├── commit.md      # → /commit
            ├── review.md      # → /review
            └── refactor.md    # → /refactor
```

### Adding a skill

Create a new directory under `skills/` with a `SKILL.md`, commit, and run `switch`.
Pi auto-discovers everything under `~/.agents/skills/`.

### How the flake is structured

`flake.nix` only declares inputs. The outputs are built by
[flake-parts](https://flake.parts), which auto-imports every `.nix` file under
`flake/` via [import-tree](https://github.com/vic/import-tree).
Adding a new host means adding a new entry in `flake/home-manager.nix`
— no need to touch `flake.nix`.

## Install

### 1. Install Nix

Using the Determinate Systems installer (recommended):

```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

### 2. Install Home Manager

```sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
```

### 3. Clone and activate

```sh
git clone https://github.com/guillaumebreton/nix-config ~/Workspaces/nix-config
cd ~/Workspaces/nix-config
home-manager switch --flake .#kami
```

### 4. Install Berkeley Mono font

After first activation, install the Berkeley Mono font manually.

## Daily usage

| Command | Description |
|---------|-------------|
| `switch` | Rebuild and activate (via `nh home switch`) — shows package diff |
| `nix fmt` | Auto-format all `.nix` files with nixfmt |
| `nix flake update` | Update all flake inputs |

## Upgrading pi

Edit `modules/pi-agent.nix` with the new version, fetch the new tarball hash,
regenerate `modules/pi-agent-package-lock.json`, then run `switch`.

## Troubleshooting

**Update flake inputs:**
```sh
nix flake update
```

**Upgrade Nix itself:**
```sh
sudo -i sh -c 'nix-channel --update && nix-env -iA nixpkgs.nix && launchctl remove org.nixos.nix-daemon && launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist'
```

**If macOS breaks the Nix shell environment** (e.g. after an OS update):
```sh
sudo vi /etc/zshrc
```
Add at the end:
```sh
# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix
```

**If you break your shell**, open a plain terminal and run:
```sh
home-manager switch --flake ~/Workspaces/nix-config#kami
```

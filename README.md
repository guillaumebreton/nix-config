# nix-home-config

Nix/Home manager configuration for my hosts.

# Debts

This config is heavily indebted to lucperkins/nix-home-config.

# Install

To use these configs yourself as a starter:

1. Install Nix

```
curl -L https://nixos.org/nix/install | sh
```

2. Install Home Manager

```
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
nix-shell '<home-manager>' -A install
```

3. Install the [FiraCode nerd font](https://www.nerdfonts.com/)
4. Run

```
home-manager home-manager switch --flake https://github.com/guillaumebreton/nix-home-config#{hostname}
```

# Trouble shooting

- If you accidently remove home-manager from nix profile: nix profile install home-manager

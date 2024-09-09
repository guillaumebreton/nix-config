# nix-home-config

Nix/Home manager configuration for my hosts.

# Install

1. Install Nix

```
curl -L https://nixos.org/nix/install | sh
```

2. Enable flakes

```
# add the following line to ~/.config/nix/nix.conf
experimental-features = nix-command flakes
```

3. Install Home Manager

```
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix flake update
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
nix-shell '<home-manager>' -A install
```

4. Install the Berkeley Mono font
5. Clone the repository in a directory
6. Run

```
home-manager switch --flake .#$(hostname -s)
cd ~/Workspaces/nix-config && home-manager switch --flake .#bunraku
```

```
switch = "nix profile list | { grep 'home-manager-path$' || test $? = 1; } | awk -F ' ' '{ print $4 }' | cut -d ' ' -f 4 | xargs -t $DRY_RUN_CMD nix profile remove $VERBOSE_ARG &&  nix build --no-link ~/Workspaces/nix-config#homeConfigurations.$(hostname -s).activationPackage && \"$(nix path-info ~/Workspaces/nix-config#homeConfigurations.$(hostname -s).activationPackage)\"/activate && source ~/.zshrc";
```

# Trouble shooting

- Update the dependencies

```
nix flake update
```

- Upgrade nix

```
sudo -i sh -c 'nix-channel --update && nix-env -iA nixpkgs.nix && launchctl remove org.nixos.nix-daemon && launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist'
```

- If you ever break your shell, open a regular terminal, remove the .zshrc from your repository and run

```
nix profile list | { grep 'home-manager-path$' || test $? = 1; } | awk -F ' ' '{ print $4 }' | cut -d ' ' -f 4 | xargs -t $DRY_RUN_CMD nix profile remove $VERBOSE_ARG &&  nix build --no-link ~/Workspaces/nix-config#homeConfigurations.$(hostname -s).activationPackage && \"$(nix path-info ~/Workspaces/nix-config#homeConfigurations.$(hostname -s).activationPackage)\"/activate && source ~/.zshrc

```

- If MacOSX break the configuration

```
sudo vi /etc/zshrc

at this at the end
# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix
```

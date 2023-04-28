# nix-home-config

Nix/Home manager configuration for my hosts.

# Debts

This config is heavily indebted to

- lucperkins/nix-home-config.
- https://www.youtube.com/watch?v=KJgN0lnA5mk
- https://gist.github.com/jmatsushita/5c50ef14b4b96cb24ae5268dab613050
- https://www.bekk.christmas/post/2021/16/dotfiles-with-nix-and-home-manager
- https://www.youtube.com/watch?v=1dzgVkgQ5mE


# TODO

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Install

To use these configs yourself as a starter:

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
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
nix-shell '<home-manager>' -A install
```

4. Install the [FiraCode nerd font](https://www.nerdfonts.com/)
5. Clone the repository
6. Run

```
home-manager switch --flake .#$(hostname -s)
cd ~/Workspaces/nix-config && home-manager switch --flake .#bunraku
```

# Trouble shooting

- Update the dependencies

```
nix flake update
# then build again
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

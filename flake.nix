{
  description = "Home manage configuration for nix systems";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    conform-nvim.url = "github:stevearc/conform.nvim";
    conform-nvim.flake = false;
  };

  outputs = inputs @ { nixpkgs, home-manager, ... }:
    let
      system = "aarch64-darwin";

      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = [
          (self: super: {
            vimPlugins =
              super.vimPlugins
              // {
                conform-nvim = super.vimUtils.buildVimPlugin {
                  name = "conform-nvim";
                  pname = "conform-nvim";
                  dontCheck = true; # doesn't work without this
                  dontBuild = true; # doesn't work without this
                  src = inputs.conform-nvim;
                };
              };
          })
        ];
      };
    in {
      # This saves an extra Nixpkgs evaluation, adds consistency, and removes the dependency on NIX_PATH, which is otherwise used for importing Nixpkgs.
      home-manager.useGlobalPkgs = true;

      # define the configuration for kami
      homeConfigurations.kami = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./profiles/kami.nix
        ];
        # use nix unstable channel in home-manager.

        extraSpecialArgs = {
            inherit nixpkgs;
        };
      };
    };
}

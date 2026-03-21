{
  description = "Home Manager configuration for macOS (aarch64-darwin)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      treefmt-nix,
      ...
    }:
    let
      system = "aarch64-darwin";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      treefmtEval = treefmt-nix.lib.evalModule pkgs {
        projectRootFile = "flake.nix";
        programs.nixfmt.enable = true;
      };
    in
    {
      homeConfigurations.kami = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./profiles/kami.nix ];
        extraSpecialArgs = { inherit nixpkgs; };
      };

      # nix fmt
      formatter.${system} = treefmtEval.config.build.wrapper;

      # nix flake check
      checks.${system}.formatting = treefmtEval.config.build.check self;
    };
}

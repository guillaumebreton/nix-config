{
  description = "Home manage configuration for nix systems";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Specify the channel to use for Home Manager and Nixpkgs.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };


  };

  outputs = { nixpkgs, home-manager, nixpkgs-unstable, ... }:
    let
      system = "x86_64-darwin";

      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };

      lib = nixpkgs.lib;
    in {
      # Use the provided nixpkgs and home-manager.
      homeConfigurations.bunraku = home-manager.lib.homeManagerConfiguration {

        inherit pkgs;
        modules = [
          ./profiles/bunraku.nix
        ];
        # use nix unstable channel in home-manager.
        extraSpecialArgs = {
            inherit nixpkgs-unstable;
        };
      };
    };
}

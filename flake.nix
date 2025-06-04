{
  description = "Home manage configuration for nix systems";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";


    # ghostty = {
    #   url = "github:ghostty-org/ghostty";
    # };


    home-manager = {
      # url = "github:nix-community/home-manager";

      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager,  ... }:
    let
      system = "aarch64-darwin";

      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
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

{

  descirption = "Test dot files"
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-22.05";
    nixpkgsUnstable.url = "github:NixOS/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # flake-utils.url = "github:numtide/flake-utils";
    # deploy-rs = {
    #   url = "github:serokell/deploy-rs";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # darwin = {
    #   url = "github:lnl7/nix-darwin/master";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = inputs : {
    homeConfigurations = {
        bunraku = inputs.home-manager.lib.homeManagerConfiguration {
          system = "x86_64-darwin";
          homeDirectory = "/Users/guillaume";
          username = "guillaume";
          configuration.imports = [
              ./home-manager.nix
          ];
        };
    };
  };
}

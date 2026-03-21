# homeConfigurations output — one entry per host
{ inputs, ... }:
{
  flake.homeConfigurations = {
    kami = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        system = "aarch64-darwin";
        config.allowUnfree = true;
      };
      modules = [ ./../../profiles/kami.nix ];
      extraSpecialArgs = { inherit inputs; };
    };
  };
}

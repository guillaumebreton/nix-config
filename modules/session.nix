# Shell session variables, path, and nixpkgs config

{ ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };

  home.sessionVariables = {
    EDITOR = "vi";
    TERMINAL = "ghostty";
    GOPATH = "$HOME/go";
    GOBIN = "$HOME/go/bin";
  };

  home.sessionPath = [ "$HOME/go/bin" ];
}

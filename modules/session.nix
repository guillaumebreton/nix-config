# Shell session variables and nixpkgs config

{ ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };

  home.sessionVariables = {
    EDITOR = "vi";
    TERMINAL = "ghostty";
  };
}

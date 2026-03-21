# Go development tools and aliases

{ pkgs, ... }:

{
  home.shellAliases = {
    gor = "go run .";
    gob = "go build .";
    got = "go test ./...";
    goi = "go install .";
  };

  home.packages = with pkgs; [
    go
    gopls # language server
    delve # debugger
    golangci-lint # linter
    air # live reload
  ];

  home.sessionVariables = {
    GOPATH = "$HOME/go";
    GOBIN = "$HOME/go/bin";
  };

  home.sessionPath = [ "$HOME/go/bin" ];
}

{ pkgs, ... }:

let
  pi-agent = pkgs.buildNpmPackage {
    pname = "pi-coding-agent";
    version = "0.58.1";

    src = pkgs.fetchzip {
      url =
        "https://registry.npmjs.org/@mariozechner/pi-coding-agent/-/pi-coding-agent-0.58.1.tgz";
      hash = "sha256-sn0wXaKEd6Ez/wKPqxtoBJA9xOyWvWKXqYMTZMI9uOQ=";
    };

    npmDepsHash = "sha256-kKOY3CJvQVkQK2hWwwKZ6/H7DMfda9AEn4sTQIm4Ag4=";

    postPatch = ''
      cp ${./pi-agent-package-lock.json} package-lock.json
    '';

    dontNpmBuild = true;

    meta = with pkgs.lib; {
      description = "Interactive coding agent CLI";
      homepage = "https://github.com/badlogic/pi-mono";
      license = licenses.mit;
      mainProgram = "pi";
    };
  };
in { home.packages = [ pi-agent ]; }

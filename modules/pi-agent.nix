{ pkgs, ... }:

let
  pi-agent = pkgs.buildNpmPackage {
    pname = "pi-coding-agent";
    version = "0.61.1";

    src = pkgs.fetchzip {
      url =
        "https://registry.npmjs.org/@mariozechner/pi-coding-agent/-/pi-coding-agent-0.61.1.tgz";
      hash = "sha256-XhVH0WG1MqezyUnpnRgVoXnFgMRxq/6id0CSEpPCWEQ=";
    };

    npmDepsHash = "sha256-HRGp2S1Zy5PER46z9mGwOPvFXcJqkIYYNIMF6h+/PDA=";

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

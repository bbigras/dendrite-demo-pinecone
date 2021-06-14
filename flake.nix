{
  description = "nix-matrix-pinecone";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    dendrite = {
      url = "github:matrix-org/dendrite";
      flake = false;
    };
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, dendrite, flake-compat }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = import nixpkgs { inherit system; }; in
        {
          defaultPackage = (import ./build.nix { inherit pkgs dendrite; }).main;
          packages.dockerImage = import ./image.nix { inherit pkgs dendrite; };
          devShell = import ./shell.nix { inherit pkgs; };
        }
      );
}

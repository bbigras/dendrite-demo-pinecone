{
  description = "nix-matrix-pinecone";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    dendrite = {
      url = "github:matrix-org/dendrite";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, dendrite }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = import nixpkgs { inherit system; }; in
        {
          defaultPackage = (import ./default.nix { inherit pkgs dendrite; }).main;
          # devShell = import ./shell.nix { inherit pkgs; };
        }
      );
}

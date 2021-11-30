{
  description = "dendrite-demo-pinecone";
  nixConfig.substituters = [ "https://dendrite-demo-pinecone.cachix.org" ];

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    dendrite = {
      url = "github:matrix-org/dendrite";
      flake = false;
    };
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };

  outputs = { nixpkgs, flake-utils, dendrite, pre-commit-hooks, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = import nixpkgs { inherit system; }; in
        {
          defaultPackage = (import ./build.nix { inherit pkgs dendrite; }).main;
          packages.dendrite = (import ./build.nix { inherit pkgs dendrite; }).main;
          packages.dockerImage = import ./image.nix { inherit pkgs dendrite; };
          devShell = import ./shell.nix { inherit pkgs pre-commit-hooks system; };
        }
      );
}

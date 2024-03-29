{
  description = "dendrite-demo-pinecone";

  nixConfig = {
    extra-substituters = [
      "https://dendrite-demo-pinecone.cachix.org"
    ];
    extra-trusted-public-keys = [
      "dendrite-demo-pinecone.cachix.org-1:qgybhOM1X0JikTrvpYo1HwtsXT2ee+6ajbmCjCns4yI="
    ];
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-parts = {
      url = "flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    dendrite = {
      url = "github:matrix-org/dendrite";
      flake = false;
    };
    flake-compat.url = "github:edolstra/flake-compat";
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
      };
    };
  };

  outputs = inputs@{ self, flake-parts, nixpkgs, pre-commit-hooks, dendrite, ... }: flake-parts.lib.mkFlake { inherit inputs; } {
    systems = [
      "aarch64-linux"
      "x86_64-linux"
    ];

    perSystem = { pkgs, system, ... }:
      {
        packages = {
          default = (import ./build.nix { inherit pkgs dendrite; }).main;
          dendrite = (import ./build.nix { inherit pkgs dendrite; }).main;
          dockerImage = import ./image.nix {
            inherit pkgs dendrite;
            inherit (self) lastModifiedDate;
          };
        };
        devShells.default = import ./shell.nix { inherit pkgs pre-commit-hooks system; };
      };
  };
}

{ sources ? import ./nix/sources.nix, nixpkgs ? sources.nixpkgs }:

let
  pkgs = import nixpkgs {
    overlays = [
      (_: _: { inherit sources; })
    ];
  };
in
with pkgs;

{
  main = buildGoModule {
    name = "nix-matrix-pinecone";

    src = fetchFromGitHub { inherit (sources.dendrite) owner repo rev sha256; };

    vendorSha256 = "sha256-V2KfGkUVP/xa/hdehghGkdfcRffvuNw/n4kKxUpTGjw=";
    subPackages = [ "cmd/dendrite-demo-pinecone" ];
  };

  test = pkgs.nixosTest ./test.nix;
}

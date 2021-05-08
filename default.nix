{ pkgs, dendrite }:

with pkgs;
{
  main = buildGoModule {
    name = "nix-matrix-pinecone";

    src = dendrite;

    vendorSha256 = "sha256-V2KfGkUVP/xa/hdehghGkdfcRffvuNw/n4kKxUpTGjw=";
    subPackages = [ "cmd/dendrite-demo-pinecone" ];
  };

  test = pkgs.nixosTest ./test.nix;
}

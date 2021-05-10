{ pkgs, dendrite }:

with pkgs;
{
  main = buildGoModule {
    name = "nix-matrix-pinecone";

    src = dendrite;

    vendorSha256 = "sha256-gVUYaa1pHkG2wPLGrfAqKS80nOF9XsctQIiIBTxJeQI=";
    subPackages = [ "cmd/dendrite-demo-pinecone" ];
  };

  test = pkgs.nixosTest ./test.nix;
}

{ pkgs, dendrite }:

with pkgs;
{
  main = buildGoModule {
    name = "nix-matrix-pinecone";

    src = dendrite;

    vendorSha256 = "sha256-4lLF3tR/6BPO+5aeanfU2qzXlykZN4rBzyjCGGhtHl4=";
    subPackages = [ "cmd/dendrite-demo-pinecone" ];
  };

  test = pkgs.nixosTest ./test.nix;
}

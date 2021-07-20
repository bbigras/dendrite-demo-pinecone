{ pkgs, dendrite }:

with pkgs;
{
  main = buildGoModule {
    name = "dendrite-demo-pinecone";

    src = dendrite;

    vendorSha256 = "sha256-5bAlBf1vGZevdtMyI1Vvfh56Kqw6okPo2S6Qcq6KM1s=";
    subPackages = [ "cmd/dendrite-demo-pinecone" ];
  };

  test = pkgs.nixosTest ./test.nix;
}

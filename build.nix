{ pkgs, dendrite }:

with pkgs;
{
  main = buildGoModule {
    name = "dendrite-demo-pinecone";

    src = dendrite;

    vendorSha256 = "sha256-J0w77G0ZMM4WUAd6Bpq5UQ90kRF2fjwwlVPCuzq62eg=";
    subPackages = [ "cmd/dendrite-demo-pinecone" ];
  };

  test = pkgs.nixosTest ./test.nix;
}

{ pkgs, dendrite }:

with pkgs;
{
  main = buildGoModule {
    name = "dendrite-demo-pinecone";

    src = dendrite;

    vendorSha256 = "sha256-ksje+WjEAWsDKlgE2qzLk/KgkYfBRQeqQ6mlSCwRrtk=";
    subPackages = [ "cmd/dendrite-demo-pinecone" ];
  };

  test = pkgs.nixosTest ./test.nix;
}

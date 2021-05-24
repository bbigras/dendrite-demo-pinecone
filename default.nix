{ pkgs, dendrite }:

with pkgs;
{
  main = buildGoModule {
    name = "nix-matrix-pinecone";

    src = dendrite;

    vendorSha256 = "sha256-XzHgacAAS49ciMkwmX/QlzxWnC9AtpCAzQye40EoiUk=";
    subPackages = [ "cmd/dendrite-demo-pinecone" ];
  };

  test = pkgs.nixosTest ./test.nix;
}

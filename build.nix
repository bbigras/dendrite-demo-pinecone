{ pkgs, dendrite }:

with pkgs;
{
  main = buildGoModule {
    name = "dendrite-demo-pinecone";

    src = dendrite;

    vendorSha256 = "sha256-M7ogR1ya+sqlWVQpaXlvJy9YwhdM4XBDw8e2ZBPvEGY=";
    subPackages = [ "cmd/dendrite-demo-pinecone" ];
  };

  test = pkgs.nixosTest ./test.nix;
}

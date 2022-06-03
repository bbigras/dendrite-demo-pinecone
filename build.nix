{ pkgs, dendrite }:

with pkgs;
{
  main = buildGoModule {
    name = "dendrite-demo-pinecone";

    src = dendrite;

    vendorSha256 = "sha256-yTlg1K0Pf1AmF227ca73gLDx12ea5yMamnOUksKGN4U=";
    subPackages = [ "cmd/dendrite-demo-pinecone" ];
  };

  test = pkgs.nixosTest ./test.nix;
}

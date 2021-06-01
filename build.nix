{ pkgs, dendrite }:

with pkgs;
{
  main = buildGoModule {
    name = "nix-matrix-pinecone";

    src = dendrite;

    vendorSha256 = "sha256-Fs28HlNxyz/oU2FRxw7QV0xkN7VKgoZ6bYUx0HWHSP8=";
    subPackages = [ "cmd/dendrite-demo-pinecone" ];
  };

  test = pkgs.nixosTest ./test.nix;
}

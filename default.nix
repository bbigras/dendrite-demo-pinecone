let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {
    overlays = [
      (_: _: { inherit sources; })
    ];
  };
in
with pkgs;

{
  main = buildGoModule {
    name = "nix-matrix-pinecone";

    src = fetchFromGitHub { inherit (sources.dendrite) owner repo rev sha256; };

    vendorSha256 = "sha256-zNamxhaSMxH0C/EZUnLjb4aigtO+HUb6cNbnAv9aaLc=";
    subPackages = [ "cmd/dendrite-demo-pinecone" ];

    patches = [ ./go.mod.diff ];
  };

  test = pkgs.nixosTest ./test.nix;
}

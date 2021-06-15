{ pkgs, dendrite }:

let
  nix-matrix-pinecone = (import ./build.nix { inherit pkgs dendrite; }).main;
in
pkgs.dockerTools.buildLayeredImage {
  name = "nix-matrix-pinecone";
  created = "now";
  tag = "latest";

  contents = [
    nix-matrix-pinecone
    pkgs.cacert
  ];
  config = {
    Cmd = [
      "dendrite-demo-pinecone"
      "-peer"
      "wss://pinecone.matrix.org/public"
      "-listen"
      ":5977"
    ];
    ExposedPorts = {
      "5977/tcp" = { };
      "5977/udp" = { };
      "60606/udp" = { };
    };
    WorkingDir = "/data";
    Volumes = {
      "/data" = { };
    };
  };
}

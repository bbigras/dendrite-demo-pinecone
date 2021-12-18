{ pkgs, dendrite }:

let
  dendrite-demo-pinecone = (import ./build.nix { inherit pkgs dendrite; }).main;
in
pkgs.dockerTools.buildLayeredImage {
  name = "dendrite-demo-pinecone";
  tag = "latest";

  contents = [
    dendrite-demo-pinecone
    pkgs.cacert
  ];
  config = {
    Entrypoint = [
      "${dendrite-demo-pinecone}/bin/dendrite-demo-pinecone"
    ];
    Cmd = [
      "-peer"
      "wss://pinecone.matrix.org/public"
      "-listen"
      ":5977"
    ];
    ExposedPorts = {
      "5977/tcp" = { };
      "5977/udp" = { };
      "8008/tcp" = { }; # client API
      "60606/udp" = { }; # multicast
    };
    WorkingDir = "/data";
    Volumes = {
      "/data" = { };
    };
  };
}

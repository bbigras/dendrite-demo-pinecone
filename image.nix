{ pkgs, dendrite, lastModifiedDate }:

let
  dendrite-demo-pinecone = (import ./build.nix { inherit pkgs dendrite; }).main;
in
pkgs.dockerTools.streamLayeredImage {
  name = "dendrite-demo-pinecone";
  tag = "latest";
  created = builtins.substring 0 8 lastModifiedDate;

  contents = [
    dendrite-demo-pinecone
    pkgs.dockerTools.caCertificates
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

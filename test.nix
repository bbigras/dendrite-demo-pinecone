{ ... }:

let
  dendrite-demo-pinecone = (import ./default.nix { }).main;
in
{
  name = "dendrite-demo-pinecone-test";
  nodes.server = { ... }: {

    systemd.services.matrix-pinecone = {
      description = "matrix-pinecone";
      serviceConfig = {
        ExecStart = "${dendrite-demo-pinecone}/bin/dendrite-demo-pinecone";
      };
      wantedBy = [ "default.target" ];
    };
  };

  testScript = ''
    start_all()
    server.wait_for_unit("matrix-pinecone.service")
  '';
}

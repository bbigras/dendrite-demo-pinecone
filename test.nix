{ ... }:

let
  nix-matrix-pinecone = (import ./default.nix).main;
in
{
  name = "nix-matrix-pinecone-test";
  nodes.server = { ... }: {

    systemd.services.matrix-pinecone = {
      description = "matrix-pinecone";
      serviceConfig = {
        ExecStart = "${nix-matrix-pinecone}/bin/dendrite-demo-pinecone";
      };
      wantedBy = [ "default.target" ];
    };
  };

  testScript = ''
    start_all()
    server.wait_for_unit("matrix-pinecone.service")
  '';
}

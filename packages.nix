# from https://github.com/colemickens/nixpkgs-wayland/blob/c9c4a80715557caf57f403038a267f3c20859424/packages.nix

let
  flake = import
    (
      let lock = builtins.fromJSON (builtins.readFile ./flake.lock); in
      fetchTarball {
        url = "https://github.com/edolstra/flake-compat/archive/${lock.nodes.flake-compat.locked.rev}.tar.gz";
        sha256 = lock.nodes.flake-compat.locked.narHash;
      }
    )
    { src = ./.; };
in
flake.defaultNix.packages."${builtins.currentSystem}"

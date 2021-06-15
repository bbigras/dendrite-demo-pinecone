# from https://github.com/colemickens/nixpkgs-wayland/blob/c9c4a80715557caf57f403038a267f3c20859424/packages.nix

# mostly used since nix-build-uncached needs it
# but also to fan out the packages into a list that only nix-build can build
let
flake = (import
  (
    let
      lock = builtins.fromJSON (builtins.readFile ./flake.lock);
    in
    fetchTarball {
      url = "https://github.com/edolstra/flake-compat/archive/${lock.nodes.flake-compat.locked.rev}.tar.gz";
      sha256 = lock.nodes.flake-compat.locked.narHash;
    }
  )
  {
    src = ./.;
  }).defaultNix;

  # flake = (import (fetchTarball {
  #   url="https://github.com/edolstra/flake-compat/archive/c75e76f80c57784a6734356315b306140646ee84.tar.gz";
  #   sha256="071aal00zp2m9knnhddgr2wqzlx6i6qa1263lv1y7bdn2w20h10h";
  # }) {
  #   src = ./.;
  # }).defaultNix;
in
  flake.packages."${builtins.currentSystem}"

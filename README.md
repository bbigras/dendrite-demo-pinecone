# dendrite-demo-pinecone [![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org) ![CI](https://github.com/bbigras/dendrite-demo-pinecone/workflows/CI/badge.svg)

⚠️ **NOTE:** This repo is not affiliated to [Matrix](https://matrix.org/) nor [Pinecone](https://pinecone-network.github.io/) in any way.

I just made this to be able to run [dendrite-demo-pinecone](https://github.com/matrix-org/dendrite/tree/master/cmd/dendrite-demo-pinecone) easily on my computers.

## Install

### Using the cachix binary cache
```sh
nix-env -if https://github.com/bbigras/dendrite-demo-pinecone/tarball/master --substituters https://dendrite-demo-pinecone.cachix.org --trusted-public-keys dendrite-demo-pinecone.cachix.org-1:qgybhOM1X0JikTrvpYo1HwtsXT2ee+6ajbmCjCns4yI=
```

## Run

```sh
dendrite-demo-pinecone -peer wss://pinecone.matrix.org/public -listen :<some_port>
```

## Docker image

[bbigras/dendrite-demo-pinecone](https://hub.docker.com/repository/docker/bbigras/dendrite-demo-pinecone) on docker hub.

```sh
docker pull bbigras/dendrite-demo-pinecone
```

To build the image:

```sh
nix-build -A packages.x86_64-linux.dockerImage

# with nix flakes
nix build .#dockerImage
```

## Acknowledgements

The auto-update script is from https://github.com/colemickens/nixpkgs-wayland.

## Contact

I'm `bbigras` in [#p2p:matrix.org](https://matrix.to/#/#p2p:matrix.org)

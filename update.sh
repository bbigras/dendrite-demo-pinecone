#!/usr/bin/env bash

# based on https://github.com/colemickens/nixpkgs-wayland/blob/c9c4a80715557caf57f403038a267f3c20859424/update.sh

set -euo pipefail
set -x

vendorSha256="$(nix-instantiate ./packages.nix -A dendrite.vendorSha256 --eval 2>/dev/null | jq -r . || echo "missing_vendorSha256")"
newvendorSha256="$(nix run nixpkgs#nix-prefetch "{ sha256 }: let p=(import ./packages.nix).dendrite; in p.goModules.overrideAttrs (_: { vendorSha256 = sha256; })")"
sed -i "s|${vendorSha256}|${newvendorSha256}|" build.nix

nix run nixpkgs#nix-build-uncached packages.nix

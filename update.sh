#!/usr/bin/env bash

# based on https://github.com/colemickens/nixpkgs-wayland/blob/c9c4a80715557caf57f403038a267f3c20859424/update.sh

set -euo pipefail
set -x

vendorHash="$(nix-instantiate ./packages.nix -A dendrite.vendorHash --eval 2>/dev/null | jq -r . || echo "missing_vendorHash")"
newvendorHash="$(nix run nixpkgs#nix-prefetch "{ sha256 }: let p=(import ./packages.nix).dendrite; in p.goModules.overrideAttrs (_: { vendorHash = sha256; })")"
sed -i "s|${vendorHash}|${newvendorHash}|" build.nix

#!/usr/bin/env bash

# based on https://github.com/colemickens/nixpkgs-wayland/blob/c9c4a80715557caf57f403038a267f3c20859424/update.sh

set -euo pipefail
set -x

vendorHash="$(nix-instantiate ./packages.nix -A dendrite.vendorHash --eval 2>/dev/null | jq -r . || echo "missing_vendorHash")"

newRev="$(nix-instantiate ./packages.nix -A dendrite.src.rev --eval | jq -r .)"

# shellcheck disable=SC2086
newvendorHash="$(nix-prefetch-github --rev ${newRev} matrix-org dendrite | jq -r .hash)"

sed -i "s|${vendorHash}|${newvendorHash}|" build.nix

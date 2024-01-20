#!/usr/bin/env bash

# based on https://github.com/colemickens/nixpkgs-wayland/blob/c9c4a80715557caf57f403038a267f3c20859424/update.sh

set -euo pipefail
set -x

vendorHash="$(nix-instantiate ./packages.nix -A dendrite.vendorHash --eval 2>/dev/null | jq -r . || echo "missing_vendorHash")"

sed -i "s|${vendorHash}|sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=|" build.nix
run_build="$(nix build 2>&1 || true)"

if [[ $run_build == *"hash mismatch in fixed-output derivation"* ]]; then
	regex="got:[ ]+(sha256[^=]+=)"

	if [[ $run_build =~ $regex ]]; then
		sed -i "s|sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=|${BASH_REMATCH[1]}|" build.nix
	fi
fi

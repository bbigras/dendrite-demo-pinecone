#!/usr/bin/env bash

vendorSha256="$(nix-instantiate ./packages.nix -A dendrite.vendorSha256 --eval 2>/dev/null | jq -r . || echo "missing_vendorSha256")"
newvendorSha256="$(nix-prefetch "{ sha256 }: let p=(import ./packages.nix).dendrite; in p.go-modules.overrideAttrs (_: { vendorSha256 = sha256; })")"
sed -i "s|${vendorSha256}|${newvendorSha256}|" build.nix

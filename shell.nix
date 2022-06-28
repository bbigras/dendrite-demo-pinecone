{ pkgs, pre-commit-hooks, system }:

let
  pre-commit-check = pre-commit-hooks.lib.${system}.run {
    src = ./.;
    hooks = {
      nixpkgs-fmt.enable = true;
      nix-linter.enable = true;
      shellcheck.enable = true;
    };
    # generated files
    excludes = [ ];
  };
in
pkgs.mkShell {
  buildInputs = [
    # keep this line if you use bash
    pkgs.bashInteractive
  ];

  shellHook = ''
    ${pre-commit-check.shellHook}
  '';
}

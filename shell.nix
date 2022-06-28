{ pkgs, pre-commit-hooks, system }:

let
  pre-commit-check = pre-commit-hooks.lib.${system}.run {
    src = ./.;
    hooks = {
      alejandra.enable = false;
      nix-linter.enable = true;
      nixpkgs-fmt.enable = true;
      shellcheck.enable = true;
      shfmt.enable = true;
      statix.enable = true;
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

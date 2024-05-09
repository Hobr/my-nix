{
  description = "GO Shell";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        overlays = [
          (final: prev: {
            # 版本
            go = prev."go_1_22";
          })
        ];

        pkgs = import nixpkgs { inherit system overlays; };
      in
      {
        devShell =
          with pkgs;
          mkShell {
            packages = with pkgs; [
              go
              gotools
              golangci-lint
            ];
          };
      }
    );
}

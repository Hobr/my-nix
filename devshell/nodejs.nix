{
  description = "Node.JS Shell";
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
          (final: prev: rec {
            nodejs = prev.nodejs_latest;
            npm = prev.nodePackages.npm;
            pnpm = prev.nodePackages.pnpm;
            yarn = (prev.yarn.override { inherit nodejs; });
          })
        ];

        pkgs = import nixpkgs { inherit overlays system; };
      in
      {
        devShell =
          with pkgs;
          mkShell {
            packages = with pkgs; [
              node2nix
              yarn2nix
              nodejs
              npm
              pnpm
              yarn
            ];
            NPM_CONFIG_REGISTRY = "https://registry.npmmirror.com";
            YARN_CONFIG_REGISTRY = "https://registry.npmmirror.com";
          };
      }
    );
}

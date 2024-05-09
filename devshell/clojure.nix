{
  description = "Clojure Shell";
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
            # 版本
            jdk = prev."jdk20";
            boot = prev.boot.override { inherit jdk; };
            clojure = prev.clojure.override { inherit jdk; };
            leiningen = prev.leiningen.override { inherit jdk; };
          })
        ];

        pkgs = import nixpkgs { inherit system overlays; };
      in
      {
        devShell =
          with pkgs;
          mkShell {
            packages = with pkgs; [
              clojure
              boot
              leiningen
            ];
            BOOT_VERSION = "2.8.3";
          };
      }
    );
}

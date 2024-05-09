{
  description = "Scala Shell";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [
          (final: prev: rec {
            # 版本
            jdk = prev."jdk20";
            sbt = prev.sbt.override { jre = jdk; };
            scala = prev.scala_3.override { jre = jdk; };
          })
        ];

        pkgs = import nixpkgs { inherit system; };
      in {
        devShell = with pkgs;
          mkShell {
            packages = with pkgs; [ scala scala-cli sbt coursier ];

            NIX_LD_LIBRARY_PATH = lib.makeLibraryPath [ circt ];
            NIX_LD = lib.fileContents "${stdenv.cc}/nix-support/dynamic-linker";
          };
      });
}

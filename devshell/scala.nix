{
  description = "Scala Shell";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs }:
    let
      javaVersion = 20;
      overlays = [
        (final: prev: rec {
          jdk = prev."jdk${toString javaVersion}";
          sbt = prev.sbt.override { jre = jdk; };
          scala = prev.scala_3.override { jre = jdk; };
        })
      ];
      supportedSystems =
        [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f:
        nixpkgs.lib.genAttrs supportedSystems
        (system: f { pkgs = import nixpkgs { inherit system; }; });
    in {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default =
          pkgs.mkShell { packages = with pkgs; [ scala sbt coursier ]; };
      });
    };
}

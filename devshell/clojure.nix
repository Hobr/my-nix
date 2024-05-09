{
  description = "Clojure Shell";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        # Java版本
        javaVersion = 20;

        overlays = [
          (final: prev: rec {
            jdk = prev."jdk${toString javaVersion}";
            boot = prev.boot.override { inherit jdk; };
            clojure = prev.clojure.override { inherit jdk; };
            leiningen = prev.leiningen.override { inherit jdk; };
          })
        ];

        pkgs = import nixpkgs { inherit system overlays; };
      in {
        devShell = with pkgs;
          mkShell rec { packages = with pkgs; [ boot clojure leiningen ]; };
      });
}

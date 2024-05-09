{
  description = "C/CPP Shell";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      supportedSystems =
        [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f:
        nixpkgs.lib.genAttrs supportedSystems
        (system: f { pkgs = import nixpkgs { inherit system; }; });
    in {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell.override {
          # 编译器
          # stdenv = pkgs.clangStdenv;
        } {
          packages = with pkgs;
            [
              gcc
              clang-tools
              codespell
              conan
              cppcheck
              doxygen
              gtest
              lcov
              vcpkg
              vcpkg-tool
              libtool
              automake
              autoconf
              cmake
              cmake-language-server
            ] ++ (if system == "aarch64-darwin" then [ ] else [ gdb ]);
        };
      });
    };
}

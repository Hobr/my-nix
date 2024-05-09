{
  description = "C/CPP Shell";
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
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShell =
          with pkgs;
          mkShell {
            packages = with pkgs; [
              gcc
              gdb
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
            ];
          };
      }
    );
}

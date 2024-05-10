{
  description = "RISC-V Shell";
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
          pkgsCross.riscv64-embedded.mkShell {
            packages = with pkgs; [
              gcc
              gdb
              qemu
            ];
          };
      }
    );
}

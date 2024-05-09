{
  description = "Python CUDA Shell";
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
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            cudaSupport = true;
          };
        };
      in
      {
        devShell =
          with pkgs;
          mkShell rec {
            venvDir = "venv";
            packages =
              with pkgs;
              [
                python311
                poetry
              ]
              ++ (with pkgs.python311Packages; [
                pip
                venvShellHook
              ])
              ++ [
                linuxPackages.nvidia_x11
                cudatoolkit
                cudaPackages.cudnn

                xorg.libXi
                xorg.libXmu
                xorg.libXext
                xorg.libX11
                xorg.libXv
                xorg.libXrandr
                zlib
                freeglut
                gcc
                stdenv.cc.cc.lib
                stdenv.cc
                ncurses5
                binutils
                gitRepo
                autoconf
                curl
                procps
                gnumake
                util-linux
                m4
                gperf
                unzip
                libGLU
                libGL
                glib
              ];
            PIP_INDEX_URL = "http://mirrors.aliyun.com/pypi/simple/";
            PIP_TRUSTED_HOST = "mirrors.aliyun.com";
            CUDA_PATH = "${pkgs.cudatoolkit}";
            LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath packages;
            EXTRA_LDFLAGS = "-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib";
          };
      }
    );
}

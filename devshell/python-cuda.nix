{
  description = "Python CUDA Shell";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            cudaSupport = true;
          };
        };
      in {
        devShell = with pkgs;
          mkShell {
            venvDir = "venv";
            packages = with pkgs;
              [ python311 poetry ]
              ++ (with pkgs.python311Packages; [ pip venvShellHook ])
              ++ [ linuxPackages.nvidia_x11 cudatoolkit cudaPackages.cudnn ];
            PIP_INDEX_URL = "http://mirrors.aliyun.com/pypi/simple/";
            PIP_TRUSTED_HOST = "mirrors.aliyun.com";
            CUDA_PATH = "${pkgs.cudatoolkit}";
            LD_LIBRARY_PATH =
              "${pkgs.linuxPackages.nvidia_x11}/lib:${pkgs.ncurses5}/lib:${pkgs.stdenv.cc.cc.lib}/lib";
            EXTRA_LDFLAGS = "-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib";
            EXTRA_CCFLAGS = "-I/usr/include";
          };
      });
}

{
  description = "Python Shell";
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
              ]);
            PIP_INDEX_URL = "http://mirrors.aliyun.com/pypi/simple/";
            PIP_TRUSTED_HOST = "mirrors.aliyun.com";
          };
      }
    );
}

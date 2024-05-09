{
  description = "Ruby Shell";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        devShell = with pkgs;
          mkShell {
            packages = with pkgs; [ ruby_3_2 ];
            shellHook = ''
              gem sources --remove https://rubygems.org/
              gem sources -a https://mirrors.aliyun.com/rubygems/
              bundle config mirror.https://rubygems.org https://mirrors.aliyun.com/rubygems
            '';
          };
      });
}

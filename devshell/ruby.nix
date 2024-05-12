{
  description = "Ruby Shell";
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
              ruby_3_2.withPackages (ps: with ps; [ rails solargraph rubocop ])
              bundler
            ];
            shellHook = ''
              gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/
              bundle config mirror.https://rubygems.org https://gems.ruby-china.com
            '';
          };
      }
    );
}

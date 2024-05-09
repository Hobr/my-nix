{
  description = "Rust Shell";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      rust-overlay,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        overlays = [
          rust-overlay.overlays.default
          (final: prev: {
            rustToolchain =
              let
                rust = prev.rust-bin;
              in
              if builtins.pathExists ./rust-toolchain.toml then
                rust.fromRustupToolchainFile ./rust-toolchain.toml
              else if builtins.pathExists ./rust-toolchain then
                rust.fromRustupToolchainFile ./rust-toolchain
              else
                rust.stable.latest.default.override {
                  extensions = [
                    "rust-src"
                    "rustfmt"
                  ];
                };
          })
        ];

        pkgs = import nixpkgs { inherit overlays system; };
      in
      {
        devShell =
          with pkgs;
          mkShell {
            packages = with pkgs; [
              rustToolchain
              openssl
              pkg-config
              cargo-deny
              cargo-edit
              cargo-watch
              rust-analyzer
            ];
            RUSTUP_UPDATE_ROOT = "https://mirrors.aliyun.com/rustup/rustup";
            RUSTUP_DIST_SERVER = "https://mirrors.aliyun.com/rustup";
            shellHook = ''
              export PATH="$PATH:~/.cargo/bin/"
            '';
          };
      }
    );
}

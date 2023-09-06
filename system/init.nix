{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # modules/nixos
    # outputs.nixosModules.example

    # flakes
    # inputs.hardware.nixosModules.common-ssd
  ];

  nixpkgs = {
    overlays = [
      # overlays\ pkgs
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # flakes
      # neovim-nightly-overlay.overlays.default
    ];

    config = {
      allowUnfree = true;
    };

    hostPlatform = "x86_64-linux";
  };

  nix = {
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  networking.hostName = "hobr-nixos";

  users.users = {
    hobr = {
      isNormalUser = true;
      extraGroups = ["wheel"];
    };
  };

  system.stateVersion = "23.05";
}

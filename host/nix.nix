{lib,inputs,config,...}:
{
  nixpkgs = {
    # 平台
    hostPlatform = "x86_64-linux";

    # 非自由软件
    config.allowUnfree = true;

    # Overlays
    overlays = [
    outputs.overlays.additions
    outputs.overlays.modifications
    outputs.overlays.unstable-packages
  ];
  };

  nix = {
    nixPath = ["/etc/nix/path"];
    registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  # 系统版本
  system.stateVersion = "23.11";
}

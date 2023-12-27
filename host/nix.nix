{ lib, inputs, outputs, config, ... }:
{
  nixpkgs = {
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
    nixPath = [ "/etc/nix/path" ];
    registry = (lib.mapAttrs (_: flake: { inherit flake; })) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;

      # 镜像
      trusted-users = [ "kanade" ];
      substituters = [ "https://mirror.sjtu.edu.cn/nix-channels/store" "http://mirrors.ustc.edu.cn/nix-channels/store/" "https://cache.nixos.org" ];
    };

    # GC
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 3d";
    };
  };

  environment.etc =
    lib.mapAttrs'
      (name: value: {
        name = "nix/path/${name}";
        value.source = value.flake;
      })
      config.nix.registry;
}

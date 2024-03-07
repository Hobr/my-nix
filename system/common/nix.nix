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
      system-features = [ "big-parallel" ];

      # Github API
      # access-tokens = "github.com=${secrets.git.github.oauth-token}";

      # 镜像
      trusted-users = [ "kanade" ];
      substituters = [
        "http://mirrors.ustc.edu.cn/nix-channels/store"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://cache.nixos.org"
      ];
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

  # 软件文档
  documentation = {
    man.enable = true;
    doc.enable = false;
    dev.enable = false;
    info.enable = false;
  };
}

{ lib, inputs, outputs, config, ... }: {
  nixpkgs = {
    config = {
      # 非自由软件
      allowUnfree = true;
      # 跨平台
      allowUnsupportedSystem = true;
    };
    # Overlays
    overlays = [
      outputs.overlays.modifications
      outputs.overlays.stable-packages
      inputs.nix-xilinx.overlay
    ];
  };

  nix = {
    nixPath = [ "/etc/nix/path" ];
    registry = (lib.mapAttrs (_: flake: { inherit flake; }))
      ((lib.filterAttrs (_: lib.isType "flake")) inputs);

    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      system-features = [ "big-parallel" ];

      # Github API
      # access-tokens = "github.com=${secrets.git.github.oauth-token}";

      # 镜像
      substituters = [
        "https://mirrors.sjtug.sjtu.edu.cn/nix-channels/store"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://hobr.cachix.org"
        "https://hyprland.cachix.org"
      ];

      trusted-public-keys = [
        "hobr.cachix.org-1:F9LxDwb6IAYpHitjzaCCxeDI3TA4obcgIlEU+7oWXzU="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };

    # GC
    gc = {
      dates = "daily";
      options = "--delete-older-than 3d";
    };
  };

  environment.etc = lib.mapAttrs' (name: value: {
    name = "nix/path/${name}";
    value.source = value.flake;
  }) config.nix.registry;

  # 软件文档
  documentation = {
    man.enable = true;
    doc.enable = false;
    dev.enable = false;
    info.enable = false;
  };
}

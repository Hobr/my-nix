{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
with lib;
{
  imports = [
    ./desktop
    ./dev
    ./media
    ./pro
    ./software
    ./util
    ./web
  ];

  nix =
    let
      flakeInputs = filterAttrs (_: isType "flake") inputs;
    in
    {
      nixPath = mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
      registry = mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      package = pkgs.nix;

      settings = {
        flake-registry = "";
        nix-path = config.nix.nixPath;
        require-sigs = false;
        builders-use-substitutes = true;

        experimental-features = [
          "cgroups"
          "nix-command"
          "flakes"
        ];

        system-features = [
          "big-parallel"
          "gccarch-x86-64-v2"
          "gccarch-x86-64-v3"
          "gccarch-x86-64-v4"
        ];

        # 镜像
        trusted-substituters = [
          "https://chaotic-nyx.cachix.org/"
          "https://mirrors.ustc.edu.cn/nix-channels/store"
          "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
          "https://nix-community.cachix.org"
        ];
      };
    };

  nixpkgs = {
    config = {
      # 非自由软件
      allowUnfree = true;
      # 破损软件
      allowBroken = true;
      # 漏洞软件
      permittedInsecurePackages = [
        "qtwebengine-5.15.19"
      ];
    };
    # Overlays
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-package

      inputs.nix-vscode-extensions.overlays.default
    ];
  };

  # 文档
  manual = {
    manpages.enable = false;
    html.enable = false;
    json.enable = false;
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";
}

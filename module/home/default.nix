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
    ./theme.nix

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
        experimental-features = "nix-command flakes";
        system-features = [ "big-parallel" ];
        flake-registry = "";
        nix-path = config.nix.nixPath;

        # Github API
        # access-tokens = "github.com=${secrets.git.github.oauth-token}";

        # 镜像
        trusted-substituters = [
          "https://chaotic-nyx.cachix.org/"
          "https://nix-community.cachix.org"
          "https://mirrors.ustc.edu.cn/nix-channels/store"
          "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        ];

        require-sigs = false;
      };
    };

  nixpkgs = {
    config = {
      # 非自由软件
      allowUnfree = true;
      # 跨平台
      allowUnsupportedSystem = true;
      # 破损软件
      allowBroken = true;
    };
    # Overlays
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-package

      inputs.nix-xilinx.overlay
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

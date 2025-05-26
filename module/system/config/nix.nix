{
  config,
  options,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.sys.config.nix;
in
{
  options.sys.config.nix.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    nix =
      let
        flakeInputs = filterAttrs (_: isType "flake") inputs;
      in
      {
        nixPath = mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
        registry = mapAttrs (_: flake: { inherit flake; }) flakeInputs;
        channel.enable = false;

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

        # GC
        gc = {
          dates = "daily";
          options = "--delete-older-than 3d";
        };
      };

    # 软件文档
    documentation = {
      man.enable = true;
      doc.enable = false;
      dev.enable = false;
      info.enable = false;
    };
  };
}

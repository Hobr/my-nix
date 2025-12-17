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
          substituters = [
            "https://cache.nixos-cuda.org"
            "https://nix-community.cachix.org"
            "https://chaotic-nyx.cachix.org/"
            "https://mirrors.ustc.edu.cn/nix-channels/store"
            "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
            "https://cache.nixos.org/"
          ];

          trusted-public-keys = [
            "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
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

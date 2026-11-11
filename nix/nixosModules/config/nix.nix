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
        registry = mapAttrs (_: flake: { inherit flake; }) flakeInputs;
        channel.enable = false;

        settings = {
          experimental-features = [
            "cgroups"
            "nix-command"
            "flakes"
          ];

          system-features = [
            "big-parallel"
            "kvm"
            "gccarch-x86-64-v2"
            "gccarch-x86-64-v3"
            "gccarch-x86-64-v4"
          ];

          # 镜像
          substituters = [
            "https://mirrors.cernet.edu.cn/nix-channels/store"
            "https://cache.nixos.org/"

            "https://cache.numtide.com"
            "https://cache.bingshan.org"
            "https://nix-community.cachix.org"
            "https://cache.nixos-cuda.org"
            "https://nyx-cache.chaotic.cx/"
          ];

          trusted-public-keys = [
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
            "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
            "cache.bingshan.org-1:HqcG/vJ7jeSLU48jV4yg8Ot+rUPP2v0vIAAnDEqVSvk="
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
            "nyx-cache.chaotic.cx:dJxTrgMC3V3cFfyIiBQDQorG6k1LsqurH/srpMSq7qk="
          ];
        };

        # GC
        gc = {
          dates = "daily";
          options = "--delete-older-than 3d";
        };
      };

    # 文档
    documentation = {
      man.enable = true;
      doc.enable = false;
      dev.enable = false;
      info.enable = false;
    };
  };
}

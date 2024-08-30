{
  config,
  options,
  lib,
  inputs,
  outputs,
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
        inputs.nix-xilinx.overlay
      ];
    };

    nix =
      let
        flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
      in
      {
        package = pkgs.nixFlakes;
        nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
        registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
        channel.enable = false;

        settings = {
          experimental-features = "nix-command flakes";
          system-features = [ "big-parallel" ];
          flake-registry = "";
          nix-path = config.nix.nixPath;

          # Github API
          # access-tokens = "github.com=${secrets.git.github.oauth-token}";

          # 镜像
          substituters = [
            "https://hobr.cachix.org"
            "https://cuda-maintainers.cachix.org"
            "https://hyprland.cachix.org"
            "https://mirrors.ustc.edu.cn/nix-channels/store"
            "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
          ];

          trusted-public-keys = [
            "hobr.cachix.org-1:F9LxDwb6IAYpHitjzaCCxeDI3TA4obcgIlEU+7oWXzU="
            "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
            "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
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

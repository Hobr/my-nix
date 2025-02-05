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
        flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
      in
      {
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
          trusted-substituters = [
            "https://cuda-maintainers.cachix.org"
            "https://mirrors.ustc.edu.cn/nix-channels/store"
            "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
          ];

          require-sigs = false;
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

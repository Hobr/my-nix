{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.dev.util;
in
{
  options.home.dev.util.enable = mkEnableOption "util";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # 工具
      cloc

      # 二进制
      ghex

      # 抓包
      reqable
    ];
  };
}

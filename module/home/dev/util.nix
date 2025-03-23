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
      # HTTP
      hoppscotch
      # 二进制
      ghex
    ];
  };
}

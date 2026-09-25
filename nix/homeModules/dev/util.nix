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
      tokei
      cloc
      gdbgui
      python3Packages.huggingface-hub
      python3Packages.hf-xet

      # 二进制
      ghex

      # 抓包/逆向
      android-tools
      apktool
      jadx
      frida-tools
      reqable
      proxypin
    ];
  };
}

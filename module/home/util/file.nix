{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.util.file;
in
{
  options.home.util.file.enable = mkEnableOption "file";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # 资源管理器
      nemo-with-extensions

      # 解压
      file-roller
      nemo-fileroller
    ];
  };
}

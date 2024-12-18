{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.pro.audio;
in
{
  options.home.pro.audio.enable = mkEnableOption "audio";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # 音频编辑
      audacity
    ];
  };
}

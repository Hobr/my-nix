{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.pro.video;
in
{
  options.home.pro.video.enable = mkEnableOption "video";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      kdePackages.kdenlive
      blender
      whisper-ctranslate2
      whisperx
    ];
  };
}

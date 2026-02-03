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
      blender
      whisper-ctranslate2
      whisperx
      python313Packages.huggingface-hub
    ];
  };
}

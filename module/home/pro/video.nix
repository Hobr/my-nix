{
  config,
  options,
  lib,
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
      kdenlive
      natron
      blender
    ];
  };
}

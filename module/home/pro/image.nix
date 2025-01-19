{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.pro.image;
in
{
  options.home.pro.image.enable = mkEnableOption "image";

  config = mkIf cfg.enable {
    home.packages = with pkgs.small; [
      # 图片处理
      gimp
      inkscape
      darktable
      rawtherapee
    ];
  };
}

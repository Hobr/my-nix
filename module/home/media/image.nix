{
  config,
  options,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
let
  cfg = config.home.media.image;
in
{
  options.home.media.image.enable = mkEnableOption "image";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # 截图
      slurp
      grim
      inputs.hyprcontrib.packages.${pkgs.system}.grimblast
      # 选色
      hyprpicker
      # 图片库
      libwebp
      imagemagick
    ];
  };
}

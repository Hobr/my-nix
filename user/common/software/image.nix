{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    # 截图
    slurp
    grim
    inputs.hyprcontrib.packages.${pkgs.system}.grimblast
    # 选色
    hyprpicker
    # 图片处理
    gimp
    inkscape
    darktable
    rawtherapee
    # 图片库
    libwebp
  ];
}

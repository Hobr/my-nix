{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    # 截图
    slurp
    grim
    # 图片处理
    gimp
    inkscape
    swappy
    darktable
    # 图片库
    libwebp
  ];
}

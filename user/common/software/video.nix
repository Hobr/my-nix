{ pkgs, inputs, ... }:
{
  programs.mpv.enable = true;

  home.packages = with pkgs; [
    ffmpeg
    yt-dlp
    # 动画
    manim
    # 编辑器
    olive-editor
    # 字幕
    inputs.hobr.packages.${pkgs.system}.aegisub
    # 补帧
    # inputs.hobr.packages.${pkgs.system}.rife-ncnn-vulkan
    # 超分
    # inputs.hobr.packages.${pkgs.system}.real-esrgan
  ];
}

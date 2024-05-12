{ pkgs, inputs, ... }:
{
  programs.mpv.enable = true;

  home.packages = with pkgs; [
    ffmpeg
    yt-dlp
    # 动画
    manim
    # 剪辑后期
    natron
    olive-editor
    # 字幕
    inputs.hobr.packages.${pkgs.system}.aegisub
    # 补帧
    # inputs.hobr.packages.${pkgs.system}.rife-ncnn-vulkan
    svp
    # 超分
    # inputs.hobr.packages.${pkgs.system}.real-esrgan
  ];
}

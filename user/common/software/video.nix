{ pkgs, inputs, ... }:
{

  programs.mpv = {
    enable = true;

    config = {
      profile = "gpu-hq";
      force-window = true;
      ytdl-format = "bestvideo+bestaudio";
    };

    scripts = with pkgs.mpvScripts; [
      mpris
      webtorrent-mpv-hook
      thumbfast
      quality-menu
      modernx
      seekTo
    ];
  };

  home.packages = with pkgs; [
    ffmpeg
    yt-dlp
    # 动画
    # manim
    # 剪辑后期
    # natron
    # olive-editor
    # 字幕
    inputs.hobr.packages.${pkgs.system}.aegisub
    # 补帧
    # inputs.hobr.packages.${pkgs.system}.rife-ncnn-vulkan
    # svp
    # 超分
    # inputs.hobr.packages.${pkgs.system}.real-esrgan
  ];
}

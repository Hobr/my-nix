{ pkgs, inputs, ... }:
{
  programs.mpv.enable = true;

  home.packages = with pkgs; [
    ffmpeg
    yt-dlp
    manim
    olive-editor
    inputs.hobr.packages.${pkgs.system}.aegisub
  ];
}

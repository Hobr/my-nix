{ pkgs, inputs, ... }:
{

  programs.mpv = {
    enable = true;
    package = pkgs.mpv.override {
      scripts = with pkgs.mpvScripts; [
        mpris
        webtorrent-mpv-hook
        thumbfast
        quality-menu
        modernx
        seekTo
      ];
    };

    config = {
      profile = "gpu-hq";
      force-window = true;
      ytdl-format = "bestvideo+bestaudio";
    };
  };

  home.packages = with pkgs; [
    ffmpeg
    yt-dlp
    mkvtoolnix
    # 字幕
    inputs.hobr.packages.${pkgs.system}.aegisub
  ];
}

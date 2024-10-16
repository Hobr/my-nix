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
    kdenlive
    blender
    # 字幕
    aegisub
    whisper-ctranslate2
  ];
}

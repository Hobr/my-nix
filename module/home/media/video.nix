{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.media.video;
in
{
  options.home.media.video = {
    enable = mkEnableOption "enable";
    subtitle = mkEnableOption "subtitle";
  };

  config = {
    programs.mpv = {
      enable = cfg.enable;
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

    home.packages =
      with pkgs;
      optionals cfg.enable [
        animeko

        ffmpeg
        yt-dlp
        mkvtoolnix
      ]
      ++ optionals cfg.subtitle [
        aegisub
        whisper-ctranslate2
      ];
  };
}

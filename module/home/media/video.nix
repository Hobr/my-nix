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
  options.home.media.video.enable = mkEnableOption "enable";

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
          mpv-playlistmanager
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
        stable.animeko
        ffmpeg
        yt-dlp
        mkvtoolnix
      ];
  };
}

{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.software.video;
in
{
  options.home.software.video = {
    base = mkEnableOption "base";
    sub = mkEnableOption "sub";
    edit = mkEnableOption "edit";
  };

  config = {
    programs.mpv = {
      enable = cfg.base;
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
      optionals cfg.base [
        ffmpeg
        yt-dlp
        mkvtoolnix
      ]
      ++ optionals cfg.sub [
        aegisub
        stable.whisper-ctranslate2
      ]
      ++ optionals cfg.edit [
        kdenlive
        natron
        blender
      ];
  };
}

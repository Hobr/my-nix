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
          uosc
          mpris
          webtorrent-mpv-hook
          thumbfast
          quality-menu
          seekTo
          mpv-playlistmanager
        ];
      };

      defaultProfiles = [ "gpu-hq" ];

      config = {
        hwdec = "auto-safe";
        vo = "gpu";
        gpu-context = "wayland";

        force-window = true;
        ytdl-format = "bestvideo+bestaudio";
      };
    };

    home.packages =
      with pkgs;
      optionals cfg.enable [
        ffmpeg
        yt-dlp
        mkvtoolnix
        losslesscut-bin
        aegisub
      ];
  };
}

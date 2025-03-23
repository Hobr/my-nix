{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.media.audio;
in
{
  options.home.media.audio.enable = mkEnableOption "audio";

  config = mkIf cfg.enable {
    # MPD
    services.mpd = {
      enable = true;
      extraConfig = "";
    };

    # MPD歌词
    services.mpd-mpris = {
      enable = true;
      mpd.useLocal = true;
    };

    # ncmpcpp
    programs.ncmpcpp = {
      enable = true;
      bindings = [ ];
      settings = { };
    };

    home.packages = with pkgs; [
      # 音乐播放器
      amberol
    ];
  };
}

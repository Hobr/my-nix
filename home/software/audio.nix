{ pkgs, lib, ... }:
{
  # MPD
  services.mpd = {
    enable = true;
    extraConfig = "";
  };

  # Playctl
  services.playerctld.enable = true;

  # MPD歌词
  services.mpd-mpris = {
    enable = true;
    mpd.useLocal = true;
  };

  # MPD客户端
  programs.ncmpcpp = {
    enable = true;
    bindings = [ ];
    mpdMusicDir = "/home/kanade/Music";
    settings = { };
  };

  # GStreamer
  home.packages = with pkgs.unstable.gst_all_1; lib.mkAfter [
    gstreamer
    gstreamer.dev
    gst-libav
    gst-vaapi
    gst-plugins-base
    gst-plugins-good
    gst-plugins-bad
    gst-plugins-ugly
    gst-plugins-rs
    gstreamermm
    gst-editing-services
  ];
}

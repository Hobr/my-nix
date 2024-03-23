{ pkgs, ... }:
{
  # MPD
  services.mpd = {
    enable = true;
    package = pkgs.unstable.mpd;
    extraConfig = "";
  };

  # Playctl
  services.playerctld = {
    enable = true;
    package = pkgs.unstable.playerctl;
  };

  # MPD歌词
  services.mpd-mpris = {
    enable = true;
    package = pkgs.unstable.mpd-mpris;
    mpd.useLocal = true;
  };

  # MPD客户端
  programs.ncmpcpp = {
    enable = true;
    package = pkgs.unstable.ncmpcpp;
    bindings = [ ];
    settings = { };
  };

  home.packages = with pkgs.unstable; [
    # 音乐播放器
    amberol
    netease-cloud-music-gtk
    playerctl

    # GStreamer
    gst_all_1.gstreamer
    gst_all_1.gstreamer.dev
    gst_all_1.gst-libav
    gst_all_1.gst-vaapi
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-plugins-rs
    gst_all_1.gstreamermm
    gst_all_1.gst-editing-services
  ];
}

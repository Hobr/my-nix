{ pkgs, ... }:
{
  # Playctl
  services.playerctld = {
    enable = true;
  };

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

  # MPD客户端
  programs.ncmpcpp = {
    enable = true;
    bindings = [ ];
    settings = { };
  };

  home.packages = with pkgs; [
    # 音乐播放器
    amberol
    qcm
    playerctl
    # 音频编辑
    audacity
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

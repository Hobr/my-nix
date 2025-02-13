{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.util.audio;
in
{
  options.home.util.audio.enable = mkEnableOption "audio";

  config = mkIf cfg.enable {
    # Playctl
    services.playerctld.enable = true;

    home.packages = with pkgs; [
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
  };
}

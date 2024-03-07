{
  programs.firefox = {
    profiles.hobr = {
      settings = {
        # 硬件加速
        "gfx.webrender.all" = true;
        "media.hardware-video-decoding.force-enabled" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.rdd-ffmpeg.enabled" = true;
        "gfx.x11-egl.force-enabled" = true;
        "widget.dmabuf.force-enabled" = true;
        "gfx.canvas.accelerated" = true;
        "gfx.webrender.enabled" = true;
        "layers.acceleration.force-enabled" = true;
        "media.av1.enabled" = false;
      };
    };
  };
}

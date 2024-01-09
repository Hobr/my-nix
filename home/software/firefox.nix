{
  home.sessionVariables.BROWSER = "firefox";

  programs.firefox = {
    enable = true;

    # https://mozilla.github.io/policy-templates/
    policies = {
      BlockAboutConfig = true;
      DisablePocket = true;
    };

    profiles.hobr = {
      isDefault = true;
      # 扩展
      extensions = [ ];
      # 设置
      settings = {
        "browser.startup.homepage" = "https://search.nixos.org/packages";
        "browser.bookmarks.showMobileBookmarks" = true;

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

{
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
      # 搜索
      search = {
        default = "Google";
        force = true;
        order = [ "Google" "Baidu" "Bing" "GitHub" ];
        engines = {
          google = {
            name = "Google";
            keyword = "google";
            searchUrl = "https://www.google.com/search?q={searchTerms}";
          };
          baidu = {
            name = "Baidu";
            keyword = "baidu";
            searchUrl = "https://www.baidu.com/s?wd={searchTerms}";
          };
          github = {
            name = "GitHub";
            keyword = "github";
            searchUrl = "https://github.com/search?q={searchTerms}&type=repositories";
          };
          bing = {
            name = "Bing";
            keyword = "bing";
            searchUrl = "https://www.bing.com/search?q={searchTerms}";
          };
        };
      };
    };
  };
}

{
  programs.firefox = {
    enable = true;

    # https://mozilla.github.io/policy-templates/
    policies = {
      BlockAboutConfig = true;
      DefaultDownloadDirectory = "\${home}/Downloads";
    };

    profiles.hobr = {
      isDefault = true;
      # 扩展
      extensions = [];
      # 设置
      settings = {
        "browser.startup.homepage" = "https://nixos.org";
        "browser.search.region" = "GB";
        "browser.search.isUS" = false;
        "distribution.searchplugins.defaultLocale" = "en-GB";
        "general.useragent.locale" = "en-GB";
        "browser.bookmarks.showMobileBookmarks" = true;
        "browser.newtabpage.pinned" = [
          {
            title = "NixOS";
            url = "https://nixos.org";
          }
        ];
      };
      # 搜索
      search = {
        default = "Google";
        force = true;
        order = ["Google", "Baidu", "Bing", "GitHub"];
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

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
      };
    };
  };
}

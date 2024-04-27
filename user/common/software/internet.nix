{ pkgs, ... }: {
  programs.firefox = {
    enable = true;

    # https://mozilla.github.io/policy-templates/
    policies = {
      DisablePocket = true;
      DisableFirefoxStudies = true;
      FirefoxHome = {
        Pocket = false;
        Snippets = false;
      };
      UserMessaging = {
        ExtensionRecommendations = false;
        SkipOnboarding = true;
      };
    };
  };

  home.sessionVariables.BROWSER = "firefox";

  home.packages = with pkgs;
    [
      # 密码管理器
      bitwarden
    ];
}

{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.web.browser;
in
{
  options.home.web.browser.enable = mkEnableOption "browser";

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;

      languagePacks = [
        "zh-CN"
        "en-US"
      ];

      # https://mozilla.github.io/policy-templates/
      policies = {
        # Updates & Background Services
        AppAutoUpdate = false;
        BackgroundAppUpdate = false;

        # Feature Disabling
        DisableFirefoxStudies = true;
        DisablePocket = true;

        # UI and Behavior
        DontCheckDefaultBrowser = true;
        HardwareAcceleration = true;

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

    home.sessionVariables = {
      BROWSER = "firefox";
      MOZ_USE_XINPUT2 = "1";
    };
  };
}

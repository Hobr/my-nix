{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.software.browser;
in
{
  options.home.software.browser.enable = mkEnableOption "browser";

  config = mkIf cfg.enable {
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
  };
}

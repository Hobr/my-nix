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
    # Chrome
    home.packages = [
      (pkgs.google-chrome.override {
        commandLineArgs = [
          "--enable-features=AcceleratedVideoDecodeLinuxGL,VaapiOnNvidiaGPUs,AcceleratedVideoEncoder,Vulkan,DefaultANGLEVulkan,VulkanFromANGLE,VaapiIgnoreDriverChecks,VaapiVideoDecoder,PlatformHEVCDecoderSupport,UseMultiPlaneFormatForHardwareVideo"
          "--ignore-gpu-blocklist"
          "--enable-zero-copy"
          "--use-gl=angle"
          "--use-angle=gl"
        ];
      })
    ];

    home.sessionVariables.BROWSER = "google-chrome";

    # Firefox
    programs.firefox = {
      enable = false;
      package = pkgs.firefox-bin;

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

    home.sessionVariables.MOZ_USE_XINPUT2 = "1";
  };
}

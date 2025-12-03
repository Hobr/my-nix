{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.sys.config.locale;
in
{
  options.sys.config.locale.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    # 时区
    time.timeZone = "Asia/Shanghai";

    # 语言
    i18n = {
      defaultLocale = "zh_CN.UTF-8";
      supportedLocales = [
        "zh_CN.UTF-8/UTF-8"
        "en_US.UTF-8/UTF-8"
      ];
    };

    # 键盘布局
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # 字体
    fonts = {
      packages = with pkgs; [
        nerd-fonts.fira-mono
        nerd-fonts.mononoki

        sarasa-gothic
        twitter-color-emoji

        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-color-emoji

        source-han-sans
        source-han-mono
        source-han-serif
        source-han-code-jp

        source-sans
        source-sans-pro
      ];

      fontconfig = {
        enable = true;
        cache32Bit = true;
        defaultFonts = {
          serif = [
            "Sarasa UI SC"
            "Noto Serif CJK SC"
            "Mononoki Nerd Font"
          ];
          sansSerif = [
            "Sarasa UI SC"
            "Noto Sans CJK SC"
            "Mononoki Nerd Font"
          ];
          monospace = [
            "Sarasa Mono SC"
            "Noto Sans Mono CJK SC"
            "Mononoki Nerd Font Mono"
          ];
          emoji = [
            "Twemoji"
            "Noto Color Emoji"
          ];
        };
      };
    };
  };
}

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
      enableDefaultPackages = true;

      packages = with pkgs; [
        maple-mono.truetype
        maple-mono.NF-unhinted
        maple-mono.NF-CN-unhinted
        sarasa-gothic

        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-color-emoji

        source-han-sans
        source-han-mono
        source-han-serif

        source-sans
        source-sans-pro

        windows-fonts
        lxgwPackages.neo-zhisong
        xiaomiPackages.misans
      ];

      fontconfig = {
        enable = true;
        defaultFonts = {
          serif = [
            "LXGW Neo ZhiSong Screen"
            "Source Han Serif SC"
          ];
          sansSerif = [
            "MiSans"
            "Source Han Sans SC"
          ];
          monospace = [
            "Maple Mono NF CN"
            "Sarasa Mono SC"
          ];
          emoji = [
            "Noto Color Emoji"
          ];
        };
      };
    };
  };
}

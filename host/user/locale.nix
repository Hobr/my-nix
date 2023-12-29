{ pkgs, ... }:
{
  # 时区
  time.timeZone = "Asia/Shanghai";

  # 语言
  i18n = {
    defaultLocale = "zh_CN.UTF-8";
    supportedLocales = [ "zh_CN.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];
  };

  # 键盘布局
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # 字体
  fonts = {
    packages = with pkgs.unstable; [
      fira-code
      mononoki
      sarasa-gothic
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];
  };
}

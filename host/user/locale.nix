{ pkgs, ... }:
{
  # 时区
  time.timeZone = "Asia/Shanghai";

  # 语言
  i18n.defaultLocale = "zh_CN.UTF-8";

  # 键盘布局
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # 字体
  fonts = {
    packages = with pkgs.unstable; [
      (nerdfonts.override { fonts = [ "FiraCode" "Mononoki" ]; })
      sarasa-gothic
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];
  };
}

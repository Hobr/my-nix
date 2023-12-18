{ pkgs, ... }:
{
  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "zh_CN.UTF-8";

  fonts = {
    packages = with pkgs.unstable; [
      (nerdfonts.override { fonts = [ "FiraCode" "Mononoki" ]; })
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];
  };
}

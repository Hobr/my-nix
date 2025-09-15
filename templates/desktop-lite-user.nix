# Template for desktop user configuration (lightweight)
# Copy this file and customize for your user
{ pkgs, ... }:
{
  imports = [ ./profiles/desktop-lite.nix ];

  home = {
    username = "<USERNAME>";
    homeDirectory = "/home/<USERNAME>";

    # 设备特定的桌面配置
    desktop = {
      hypr = {
        nvidia = false; # 便携设备通常使用集成显卡
        monitor = [ "eDP-1,2160x1350@60,auto,1" ];
      };
    };
  };

  # 壁纸 (可选)
  stylix.image = pkgs.fetchurl {
    url = "<WALLPAPER_URL>";
    hash = "<WALLPAPER_HASH>";
  };
}
{ pkgs, ... }:
{
  imports = [ ./profiles/desktop-lite.nix ];

  home = {
    username = "yuzuru";
    homeDirectory = "/home/yuzuru";

    # Portable laptop 特定的桌面配置
    desktop = {
      hypr = {
        nvidia = false;
        monitor = [ "eDP-1,2160x1350@60,auto,1" ];
      };
    };
  };

  # 壁纸
  stylix.image = pkgs.fetchurl {
    url = "https://images.alphacoders.com/499/499786.png";
    hash = "sha256-zblZCkXLc5rt4bimLpWfbj+mYzaVL55L+D/R5HQhjO8=";
  };
}

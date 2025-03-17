{ pkgs, ... }:
{
  imports = [ ./common.nix ];

  home = {
    username = "yuzuru";
    homeDirectory = "/home/yuzuru";

    desktop = {
      hypr = {
        nvidia = false;
        monitor = [ "eDP-1,2160x1350@60,auto,1" ];
      };
    };

    media.video.subtitle = true;

    pro = {
      audio.enable = false;
      video.enable = false;
      image.enable = false;
      obs.enable = false;
      electron.enable = false;
    };
  };

  # 壁纸
  stylix.image = pkgs.fetchurl {
    url = "https://images.alphacoders.com/499/499786.png";
    hash = "sha256-zblZCkXLc5rt4bimLpWfbj+mYzaVL55L+D/R5HQhjO8=";
  };
}

{
  pkgs,
  lib,
  ...
}:
{
  imports = [ ./common.nix ];

  home = {
    username = "kanade";
    homeDirectory = "/home/kanade";

    desktop = {
      hypr = {
        nvidia = true;
        monitor = [
          "DP-1,2560x1440@180,0x0,1"
          "eDP-1,2560x1440@165,auto,1.07"
        ];
      };

    };
  };

  # 壁纸
  stylix.image = pkgs.fetchurl {
    /*
      url = "https://images5.alphacoders.com/941/941673.png";
      hash = "sha256-nknMKEWpm2pyHbdW83x0/ixPmfbpWRfGt8Z12YYPAlE=";
    */
    url = "https://images.alphacoders.com/499/499786.png";
    hash = "sha256-zblZCkXLc5rt4bimLpWfbj+mYzaVL55L+D/R5HQhjO8=";
  };

  nixpkgs.config.cudaSupport = true;
}

{ pkgs, ... }:
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
          "eDP-1,2560x1440@165,auto,1.25"
        ];
      };

    };

    media.video.subtitle = true;

    pro = {
      audio.enable = false;
      video.enable = false;
      image.enable = true;
      obs.enable = true;
      electron.enable = false;
    };
  };

  # 壁纸
  stylix.image = pkgs.fetchurl {
    url = "https://images5.alphacoders.com/941/941673.png";
    hash = "sha256-nknMKEWpm2pyHbdW83x0/ixPmfbpWRfGt8Z12YYPAlE=";
  };

  nixpkgs.config.cudaSupport = true;
}

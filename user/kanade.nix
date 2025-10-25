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
          "eDP-1,2560x1440@165,auto,1.25"
        ];
      };

    };

    pro.video.enable = lib.mkForce true;
  };

  # 壁纸
  stylix.image = pkgs.fetchurl {
    url = "https://images5.alphacoders.com/941/941673.png";
    hash = "sha256-nknMKEWpm2pyHbdW83x0/ixPmfbpWRfGt8Z12YYPAlE=";
  };

  nixpkgs.config = {
    cudaSupport = true;
    cudaCapabilities = [ "8.6" ];
    cudaForwardCompat = false;
  };
}

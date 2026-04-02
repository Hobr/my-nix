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
          "eDP-1,2560x1440@165,auto,1"
        ];
      };

    };
  };

  # 壁纸
  stylix.image = ./wallpaper.jpg;

  nixpkgs.config.cudaSupport = true;
}

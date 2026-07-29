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
          {
            output = "eDP-1";
            mode = "2560x1440@165";
            position = "auto";
            scale = 1;
          }
        ];
      };

    };
  };

  # 壁纸
  stylix.image = ./wallpaper.jpg;

  nixpkgs.config.cudaSupport = true;
}

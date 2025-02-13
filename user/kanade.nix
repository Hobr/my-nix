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
        wallpaper = {
          preload = [ "/mnt/data/Project/my-nix/dist/wallpaper/1.png" ];
          monitor = [
            "eDP-1,/mnt/data/Project/my-nix/dist/wallpaper/1.png"
            "DP-1,/mnt/data/Project/my-nix/dist/wallpaper/1.png"
          ];
        };
      };

    };

    media.video.subtitle = true;

    pro = {
      audio.enable = true;
      video.enable = true;
      image.enable = true;
      obs.enable = true;
      electron.enable = true;
    };
  };

  nixpkgs.config.cudaSupport = true;
}

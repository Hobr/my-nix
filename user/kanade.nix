{
  imports = [ ./common ];

  home = {
    username = "kanade";
    homeDirectory = "/home/kanade";
    stateVersion = "24.11";

    desktop = {
      hypr = {
        enable = true;
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

    software = {
      video = {
        base = true;
        sub = true;
        edit = false;
      };
    };
  };

  nixpkgs.config.cudaSupport = true;
}

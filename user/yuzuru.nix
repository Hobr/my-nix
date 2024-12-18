{
  imports = [ ./common.nix ];

  home = {
    username = "yuzuru";
    homeDirectory = "/home/yuzuru";

    desktop = {
      hypr = {
        nvidia = false;
        monitor = [ "eDP-1,2160x1350@60,auto,1" ];
        wallpaper = {
          preload = [ "/mnt/windows/Users/SyncthingServiceAcct/Project/my-nix/dist/wallpaper/1.png" ];
          monitor = [ "eDP-1,/mnt/windows/Users/SyncthingServiceAcct/Project/my-nix/dist/wallpaper/1.png" ];
        };
      };

    };

    media.video.subtitle = false;

    pro = {
      audio.enable = false;
      video.enable = false;
      image.enable = false;
      obs.enable = false;
      electron.enable = false;
    };
  };
}

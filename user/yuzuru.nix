{
  imports = [ ./common ];

  home = {
    username = "yuzuru";
    homeDirectory = "/home/yuzuru";
    stateVersion = "24.05";

    desktop = {
      hypr = {
        monitor = [ "eDP-1,2160x1350@60,auto,1" ];
        wallpaper = {
          preload = [ "/mnt/windows/Users/SyncthingServiceAcct/Project/my-nix/dist/wallpaper/1.png" ];
          monitor = [ "eDP-1,/mnt/windows/Users/SyncthingServiceAcct/Project/my-nix/dist/wallpaper/1.png" ];
        };
      };
    };
  };
}

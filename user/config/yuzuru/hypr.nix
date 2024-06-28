{
  wayland.windowManager.hyprland = {
    # 设置
    settings = {
      monitor = [ "eDP-1,2160x1350@60,auto,1" ];
    };
  };
  services.hyprpaper.enable = true;
  services.hyprpaper.settings = {
    preloads = [ "/mnt/windows/Users/SyncthingServiceAcct/Project/my-nix/dist/wallpaper/1.png" ];
    wallpapers = [
      "eDP-1,/mnt/windows/Users/SyncthingServiceAcct/Project/my-nix/dist/wallpaper/1.png"
    ];
  };
}

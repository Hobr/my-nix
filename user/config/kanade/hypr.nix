{
  wayland.windowManager.hyprland = {
    # 设置
    settings = {
      monitor = [ "eDP-1,2560x1440@165,auto,1.25" ];

      env = [
        # NVIDIA
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "LIBVA_DRIVER_NAME,nvidia"
        "NVD_BACKEND,direct"
        "MOZ_X11_EGL,1"
        "MOZ_DISABLE_RDD_SANDBOX,1"
        "WLR_NO_HARDWARE_CURSORS,1"
      ];
    };
  };

  services.hyprpaper = {
    preloads = [ "/mnt/data/Project/my-nix/dist/wallpaper/1.png" ];
    wallpapers = [ "eDP-1,/mnt/data/Project/my-nix/dist/wallpaper/1.png" ];
  };
}

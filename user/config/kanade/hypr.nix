{
  wayland.windowManager.hyprland = {
    # 设置
    settings = {
      monitor = [
        "DP-1,2560x1440@180,0x0,1"
        "eDP-1,2560x1440@165,auto,1.25"
      ];

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

  services.hyprpaper.enable = true;
  services.hyprpaper.settings = {
    preload = [ "/mnt/data/Project/my-nix/dist/wallpaper/1.png" ];
    wallpaper = [
      "eDP-1,/mnt/data/Project/my-nix/dist/wallpaper/1.png"
      "DP-1,/mnt/data/Project/my-nix/dist/wallpaper/1.png"
    ];
  };
}

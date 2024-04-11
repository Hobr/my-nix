{
  wayland.windowManager.hyprland = {
    # 设置
    settings = {
      monitor = [ "eDP-1,2560x1440@165,auto,1.25" ];

      env = [
        # NVIDIA
        "LIBVA_DRIVER_NAME,nvidia"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "WLR_NO_HARDWARE_CURSORS,1"
        "NVD_BACKEND,direct"
      ];
    };
  };
}

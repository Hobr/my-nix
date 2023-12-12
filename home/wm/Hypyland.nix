{ config, pkgs, ... }: {
  wayland.windowManager.Hyprland = {
    enable = true;
    systemdIntegration = true;
    xwayland.enable = true;
  };
}

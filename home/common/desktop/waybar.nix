{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    package = pkgs.unstable.waybar;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };

    settings = {
      mainBar = {
        layer = "top";
      };
    };
  };

  # 状态栏
  services.network-manager-applet.enable = true;
  services.blueman-applet.enable = true;
}

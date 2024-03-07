{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    package = pkgs.unstable.waybar;
  };

  # 状态栏
  services.network-manager-applet.enable = true;
  services.blueman-applet.enable = true;
}

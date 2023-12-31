{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
  };

  # 状态栏
  services.network-manager-applet.enable = true;
  services.blueman-applet.enable = true;
}

{
  programs.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
  };

  # GDM
  services.xserver.enable = true;
  services.xserver.displayManager = {
    gdm = {
      enable = true;
      wayland = true;
    };

    # 自动登录
    autoLogin = {
      enable = true;
      user = "kanade";
    };
  };

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
}

{
  services.xserver.enable = true;

  services.xserver.displayManager = {
    #defaultSession = "Hyprland";
    gdm = {
      enable = true;
      wayland = true;
    };
  };

  # 自动启动
  #services.xserver.displayManager.autoLogin.enable = true;
  #services.xserver.displayManager.autoLogin.user = "kanade";
  #systemd.services."getty@tty1".enable = false;
  #systemd.services."autovt@tty1".enable = false;
}

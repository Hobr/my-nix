{ inputs, pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager = {
    # GDM
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

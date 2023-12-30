{ inputs, pkgs, ... }:
{
  imports = [ inputs.hyprland.nixosModules.default ];

  services.xserver.enable = true;

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

  # Hyprland
  programs.hyprland.enable = true;

  #systemd.services."getty@tty1".enable = false;
  #systemd.services."autovt@tty1".enable = false;
}

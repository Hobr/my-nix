{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.desktop.secure;
in
{
  options.home.desktop.secure = {
    lock = mkEnableOption "lock";
    logout = mkEnableOption "logout";
  };

  config = {
    # 锁屏
    programs.swaylock = {
      enable = cfg.lock;
      package = pkgs.swaylock-effects;

      settings = {
        screenshots = true;
        clock = true;
        fade-in = 0.2;

        indicator = true;
        indicator-radius = 100;
        indicator-thickness = 7;
      };
    };

    # 关机
    programs.wlogout = {
      enable = cfg.logout;
      layout = [
        {
          label = "lock";
          action = "swaylock";
          text = "Lock";
          keybind = "l";
        }
        {
          label = "hibernate";
          action = "systemctl hibernate";
          text = "Hibernate";
          keybind = "h";
        }
        {
          label = "logout";
          action = "loginctl terminate-user $USER";
          text = "Logout";
          keybind = "e";
        }
        {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "Shutdown";
          keybind = "s";
        }
        {
          label = "suspend";
          action = "systemctl suspend";
          text = "Suspend";
          keybind = "u";
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          text = "Reboot";
          keybind = "r";
        }
      ];
    };
  };
}

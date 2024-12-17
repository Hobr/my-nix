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
    # 粘贴板
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
      layout = [ ];
      style = "";
    };
  };
}

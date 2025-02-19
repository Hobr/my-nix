{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.sys.desk.hyprland;
in
{
  options.sys.desk.hyprland.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    # Greet
    environment.etc."greetd/environments".text = ''
      Hyprland
    '';

    services.greetd = {
      enable = true;
      settings = rec {
        initial_session.command = "Hyprland";
        default_session = initial_session;
      };
    };

    # Hyprland
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    # XDG
    xdg.portal.enable = true;
    environment.systemPackages = [ pkgs.xdg-utils ];

    # Seatd
    services.seatd = {
      enable = true;
      group = "wheel";
      user = "root";
    };

    # 能耗管理
    services.tlp = {
      enable = true;
      settings = {
        # 全局
        TLP_DEFAULT_MODE = "AC";
        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "low-power";

        # 网络
        RESTORE_DEVICE_STATE_ON_STARTUP = 1;
        WIFI_PWR_ON_AC = "off";
        WIFI_PWR_ON_BAT = "on";

        # CPU
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 0;
      };
    };
  };
}

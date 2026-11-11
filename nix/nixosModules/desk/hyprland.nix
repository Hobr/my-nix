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
  sessionCommand = "${lib.getExe config.programs.uwsm.package} start -e -D Hyprland hyprland.desktop";
in
{
  options.sys.desk.hyprland.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    # Greet
    services.greetd = {
      enable = true;
      useTextGreeter = true;
      settings = {
        initial_session.command = sessionCommand;
        default_session = {
          command = "${config.services.greetd.package}/bin/agreety --cmd ${escapeShellArg sessionCommand}";
          user = "greeter";
        };
      };
    };

    # Hyprland
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

    # XDG
    xdg.portal.enable = true;
    environment.systemPackages = [ pkgs.xdg-utils ];

    # 能耗管理
    services.tlp = {
      enable = true;
      pd.enable = false;

      package = pkgs.tlp.override {
        enableRDW = config.networking.networkmanager.enable;
        x86_energy_perf_policy = config.boot.kernelPackages.x86_energy_perf_policy;
      };

      settings = {
        # 性能
        TLP_AUTO_SWITCH = 1;
        TLP_PROFILE_DEFAULT = "PRF";
        TLP_PROFILE_AC = "PRF";
        TLP_PROFILE_BAT = "BAL";

        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "low-power";

        # CPU
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 0;

        # 网络
        RESTORE_DEVICE_STATE_ON_STARTUP = 1;
        WIFI_PWR_ON_AC = "off";
        WIFI_PWR_ON_BAT = "on";
      };
    };
  };
}

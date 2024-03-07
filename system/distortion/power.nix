{
  powerManagement.enable = true;

  # 能耗管理
  services.tlp = {
    enable = true;
    settings = {
      # 全局
      TLP_DEFAULT_MODE = "AC";
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      # 硬盘
      DISK_DEVICES = "nvme0n1";

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

  # 温度管理
  services.thermald.enable = true;

  # ACPI
  services.acpid.enable = true;
}
